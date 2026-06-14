# ADR 001: Operation Envelope and Module Interaction

**Status:** Accepted  
**Date:** 2025-06  
**Context:** Modules must coordinate through Core without direct storage access. The operation envelope is the primary contract for all significant mutations.

## Decision

All significant mutations flow through a **standard operation envelope** executed by the Core **Orchestrator**. Modules register **step handlers** and optional **compensators** via manifest. The orchestrator manages **workflow locks**, **failure classification**, **optional retries**, and **compensation**.

## Operation envelope shape

```typescript
interface OperationEnvelope {
  operationId: string;
  surfaceId: string;
  action: 'load' | 'save' | 'draft' | 'archive' | 'approve' | 'sync';
  entityPublicId?: string;
  entityVersion?: number;
  initiatedBy: string;       // user public id
  orgId: string;
  timestamp: string;         // ISO-8601
  payload: Record<string, unknown>;
  steps: OperationStep[];
  lock?: WorkflowLock;
  outcome?: 'success' | 'partial' | 'failed';
}

interface OperationStep {
  stepId: string;
  moduleId: string;
  status: 'pending' | 'running' | 'success' | 'failed' | 'skipped' | 'compensated';
  failureClass: 'required' | 'optional' | 'advisory';
  retryPolicy?: RetryPolicy;
  attempt: number;
  input: Record<string, unknown>;   // Public IDs and contract-shaped data only
  result?: Record<string, unknown>;
  error?: { code: string; message: string };
}

interface WorkflowLock {
  resourceType: string;
  resourcePublicId: string;
  expectedVersion: number;
  lockedBy: string;          // operationId
  expiresAt: string;
}

interface RetryPolicy {
  maxAttempts: number;
  backoffMs: number;
}
```

## Execution rules

### 1. Lock acquisition

Before executing mutating steps, the orchestrator acquires a **workflow lock** on the target entity (resource type + public id + version). Concurrent operations on the same entity are rejected with `409 Conflict` until the lock is released or expires.

Drawing approval, proposal sign-off, and Save flows all use the same lock mechanism.

### 2. Step execution order

Steps run in manifest-declared order for the surface action. Each module:

- Receives **Public IDs** only in `input`
- Resolves internal IDs inside its own boundary
- Returns contract-shaped `result` or `error`
- Never reads or writes another module's tables directly

### 3. Failure classes

| Class | On failure |
|-------|------------|
| **required** | Stop; run compensators for completed steps in reverse order; outcome `failed` |
| **optional** | Retry per `retryPolicy`; if exhausted, record warning and continue; outcome may be `partial` |
| **advisory** | Log; never block |

Optional failures **must not** leave the system silently out of sync — exhausted retries are recorded on the operation log and surfaced to the caller.

### 4. Compensation (saga-lite)

Modules declare `compensate(stepInput, stepResult)` for reversible steps. On required failure after partial success, compensators run in **reverse step order**.

Full Temporal/saga upgrade path remains open if workflows become long-running.

### 5. Cross-module data access

Modules do **not** hook into each other's storage. They hook through:

1. **Orchestrator step inputs/outputs** — structured data in the envelope
2. **Contract events** — published after successful steps (outbox)
3. **Public ID references** — e.g. Inventory step receives `productPublicId`; Finance step receives pricing deltas in `input`, not a SQL join

### Example: Save Product

| Step | Module | failureClass | input (excerpt) |
|------|--------|--------------|-----------------|
| 1 | inventory | required | `{ productPublicId, fields… }` |
| 2 | finance | optional | `{ productPublicId, costDelta }` |
| 3 | sustainability | advisory | `{ productPublicId, attributes }` |

Inventory failure → compensate none (nothing committed). Finance failure after retries → partial save with warnings. Sustainability failure → informational only.

### Example: Drawing approval pipeline

| Step | Module | Notes |
|------|--------|-------|
| 1 | build | Submit drawing revision (lock on drawing public id) |
| 2 | workflow | Assign reviewers from config |
| 3 | build | Record approval signatures |

Config-first pipeline definition; modules supply step handlers.

## Module registration

In `erganis.module.yaml`:

```yaml
contributions:
  operations:
    - surfaceId: product
      action: save
      stepId: inventory-save
      handler: ./handlers/save-product.js
      failureClass: required
      compensate: ./handlers/compensate-save-product.js
```

## Persistence

- Operation log stored in Core PostgreSQL (audit, replay, troubleshooting)
- Locks stored with TTL; expired locks auto-release with alert

## Consequences

- **Positive:** Consistent behavior across UI, API, and integrations; clear module boundaries; audit trail
- **Negative:** Orchestrator complexity; modules must implement idempotent steps where retries apply
- **Next:** Worked examples in spec for Save Product and drawing approval; JSON Schema for envelope in `core/contracts/schemas/`

## References

- [erganis_architecture_spec.md](../erganis_architecture_spec.md) §15–17
- [IDEAS.md](../../.apm/_WORKSPACE/IDEAS.md)
