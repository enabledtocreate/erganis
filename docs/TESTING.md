# Erganis — Testing Strategy

## Recommendation: Two-Level Layout

| Test type | Where it lives | Why |
|-----------|----------------|-----|
| **Unit + in-repo integration** | Inside each repo | Tests stay with the code they test; run with that repo’s stack (Jest, xUnit, pytest, etc.). |
| **Cross-repo integration + E2E** | Parent repo only | Need full platform (all submodules); one place to run “whole system” tests. |

No separate `erganis-tests` repo. Unit/integration that touch only one repo live there; everything that spans repos lives in the parent.

---

## 1. Unit and in-repo integration (per repo)

**Location:** Inside the repo that owns the code.

**Structure (pick one per repo and stick to it):**

- **Option A — Co-located:** `src/foo.ts` + `src/foo.test.ts` (or `foo.spec.ts`)
- **Option B — Dedicated folder:** `tests/` mirroring source, e.g. `tests/unit/`, `tests/integration/`

**Per-repo test READMEs:** Each repo has a `tests/README.md` describing what goes where (contracts, apps, services, packages, infrastructure).

**Examples:**

- `platform/contracts/tests/` — Schema validation, SDK generation smoke tests
- `studio-portal/studio/tests/` or `studio-portal/studio/src/**/*.test.tsx` — Unit + component tests (and same for client-portal)
- `platform/services/business-logic/tests/` — Unit + integration tests for that service
- `platform/packages/ui/tests/` — Component/library tests
- `platform/infrastructure/dal/tests/` — DAL unit tests (mocked DB or test container)

**Tooling:** Use the standard stack for that repo (e.g. Jest/Vitest for TS/JS, xUnit/NUnit for .NET, pytest for Python). No single tool across all repos.

**CI:** Each repo’s CI runs its own tests (`npm test`, `dotnet test`, etc.).

---

## 2. Cross-repo integration and E2E (parent repo only)

**Location:** Parent repo, e.g. `erganis/tests/` (only when using submodules).

**Structure:**

```
erganis/
  tests/
    integration/   # Services + DAL + DB, API + apps (backend flows)
    e2e/           # Full user flows (e.g. Playwright/Cypress against studio app)
    fixtures/      # Shared test data, wire mock configs
```

**When they run:**

- After submodules are checked out (`git clone --recurse-submodules` or `git submodule update --init --recursive`).
- From scripts: e.g. `./scripts/test-integration.sh`, `./scripts/test-e2e.sh`, or npm scripts at repo root.
- In CI: a parent-repo workflow that checks out submodules, builds services/apps, then runs `tests/integration` and `tests/e2e`.

**Why parent and not a separate repo:**

- Cross-repo and E2E tests need every relevant submodule; the parent already groups them.
- One place to run “full platform” tests without maintaining another repo or duplicate clone logic.
- Version alignment is natural: the parent commit pins submodule versions, so tests always run against a consistent set of code.

---

## 3. Test pyramid (how much of each)

- **Unit:** Most tests; fast; in each repo.
- **In-repo integration:** Fewer; service + DB or app + mock API; in that repo.
- **Cross-repo integration:** Fewer; critical paths across services/DAL/DB; in parent `tests/integration/`.
- **E2E:** Fewest; critical user journeys; in parent `tests/e2e/`.

---

## 4. Contract testing (optional)

- **Schema/contract validation:** In `contracts` repo (e.g. OpenAPI lint, SDK build + smoke tests).
- **Consumer-driven (e.g. Pact):** Either in `contracts` or in parent `tests/`; avoid duplicating contract definitions.

---

## Summary

- **Cleanest:** Unit and in-repo integration **in each repo** with that repo’s tooling; cross-repo integration and E2E **only in the parent** under `tests/integration/` and `tests/e2e/`, run when the full platform is checked out.
- **No** separate `erganis-tests` repo.
- CI: per-repo jobs for unit/in-repo tests; parent-repo job(s) for integration and E2E after submodule checkout and build.
