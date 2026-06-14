# Erganis Ideas

Volatile scratch space for architectural ideas, assumptions, and early decisions.

For **backlog and remaining questions**, see [TODO.md](./TODO.md).

---

## Terminology

| Term | Meaning |
|------|---------|
| **Erganis Platform** | The whole ecosystem |
| **Core** | Base layer — contracts, runtime, orchestration (`core/`, `erganis-core`) |
| **Erganis Agora** | Public vendor website + global catalog |
| **Studio Agora plugin** | Org-scoped vendors + trade account tracking inside Studio |
| **Guild** | Optional domain term for vendor collectives — not a repo or product name |
| Avoid in UX | "Marketplace" |

---

## Core Vision

Erganis Platform is **modular**, not monolithic.

**Core responsibilities:**

- Runtime hosting, contracts, orchestration, identity, workflow, composition, APIs
- Universal foundation for **Studio**, **Agora**, **Companion**, and future apps

**Business capabilities** live in **modules** (plugins), primarily in Studio; Agora has its own service boundary.

---

## Parent Project Structure

| Child | Path | GitHub repo | Role |
|-------|------|-------------|------|
| **Core** | `core/` | `erganis-core` | Libraries, contracts, Nest runtime, SDK generation |
| **Studio** | `studio/` | `erganis-studio` | Designer + client apps; first-party and third-party modules |
| **Agora** | `agora/` | `erganis-agora` | Standalone public site + separate Nest API/DB |
| **Companion** | `companion/` | `erganis-companion` | Mobile app (Public API consumer) |

### Core layout

| Folder | Purpose |
|--------|---------|
| `contracts/` | OpenAPI schemas; SDK output in `contracts/sdk/` |
| `services/` | NestJS Core runtime |
| `data/` | PostgreSQL DAL, migrations |
| `packages/` | Shared TS libraries |
| `infrastructure/` | Deploy; Docker optional |
| `scripts/` | Setup, migrate, update CLI |

### Studio layout

```
studio/
├── apps/studio/       # designer app
├── apps/client/       # client portal
├── modules/           # first-party plugins (agora, documents, inventory, …)
├── modules/third-party/
└── shared/
```

### SDK location

- **Source of truth:** `core/contracts/schemas/core/openapi.yaml`
- **Generated SDKs:** `core/contracts/sdk/typescript/`, etc.
- Apps consume published/generated packages — no hand-written SDKs in app repos.

---

## Erganis Agora (dual model)

Two components, **same vendor interfaces** (Core contracts):

| Surface | Users | Database | Trade accounts |
|---------|-------|----------|----------------|
| **Erganis Agora (web)** | Public, vendors | Agora PostgreSQL (large) | Vendors add onboarding links only |
| **Studio Agora plugin** | Design firm staff | Core PostgreSQL (org-scoped) | Manual tracking, Documents integration, "Already done" |

- Vendors may exist in Studio but not appear on public Agora initially.
- **Separate Agora API + database**; sync jobs keep vendor profiles aligned.
- Background job: match org vendors to global Agora entries; offer sync to user.
- **MapLibre** for web and mobile (free tiles; geo provider behind adapter).

### Vendor onboarding profile (contract)

- `resaleCertificateEmail`
- `resaleCertificateFormUrl`
- `tradeAccountCheckUrl` (optional)

Public Agora: vendors maintain profile. Studio plugin: org trade status + document apply (e.g. NY resale cert).

---

## Studio modules (first-party)

| Module | Notes |
|--------|-------|
| **Agora** | Studio plugin — org vendors, trade tracking |
| **Documents** | Certs, attachments |
| **Inventory** | |
| **Calendar** | Showings, openings |
| **Business** | Clients, metrics, Reports |
| **Design** | Interior designer areas |
| **Build** | Architect areas |
| **Tools** | Room size planner (IBC); candidate shared module |
| **Presentations** | Client proposals, comments, approvals |
| **Planner** | Kanban, Gantt, MEP, rotations |

**Module API rule:** If external apps consume a capability, it must be exposed via Surface/Public API.

---

## Architectural Principles

- **Contracts over implementation** — modules interact via contracts, not shared storage
- **Composition over coupling** — data, validation, UI, workflow, jobs
- **Workflow first** — not CRUD-first
- **Core is universal** — Studio is flagship; Core builds any Erganis application

---

## Operation envelope (priority)

Most important contract for module interaction. See [docs/adr/001-operation-envelope.md](../docs/adr/001-operation-envelope.md).

- Envelope: `operationId`, surface, action, steps[], failureClass, outcome
- Cross-module hooks via orchestrator; Public IDs in envelope
- **Workflow locks** on affected entries during active workflows
- **Optional failures:** retry policy — avoid silent drift
- **Compensation** on required failure (saga-lite)

---

## Module manifest

- **Authoring:** `erganis.module.yaml` (human-readable)
- **Runtime:** `erganis.module.json` (compiled)
- **Validation:** JSON Schema; CI compiles YAML → JSON

---

## Stack (v1)

See [docs/STACK.md](../docs/STACK.md) for full table and flowchart.

| Layer | v1 choice |
|-------|-----------|
| Experience | React, Next.js, TypeScript |
| API / Orchestration | **NestJS** |
| Persistence | PostgreSQL 16 (Core DB + Agora DB) |
| Jobs | **pg-boss** (PostgreSQL-backed; no Redis required) |
| Events | PostgreSQL outbox + poller |
| Search | PostgreSQL full-text; dedicated engine later |
| Files | **LocalFileStore** (`ERGANIS_DATA_ROOT`); S3 adapter later |
| Maps | **MapLibre** (web + React Native) |
| Permissions | Org-scoped RBAC |
| Workflows | Config-first; visual builder later |

**Deploy:** Windows and Linux native; Docker optional for local Postgres only.

---

## File storage use cases (v1 local)

| Use case | Module | Path pattern |
|----------|--------|--------------|
| Resale certs | Documents | `{dataRoot}/{orgId}/documents/` |
| Drawings | Build / approval | `{dataRoot}/{orgId}/drawings/` |
| Presentations | Presentations | `{dataRoot}/{orgId}/presentations/` |
| Reports | Business | `{dataRoot}/{orgId}/reports/` |

---

## Source documents

- [docs/erganis_architecture_spec.md](../docs/erganis_architecture_spec.md)
- [docs/STACK.md](../docs/STACK.md)
- [docs/adr/001-operation-envelope.md](../docs/adr/001-operation-envelope.md)
