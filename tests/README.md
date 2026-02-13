# Erganis — Cross-repo and E2E tests

Tests in this folder require the **full platform** (all submodules checked out). They are run from the **parent repo** only.

## Structure

- **integration/** — Cross-repo integration tests (e.g. API + DAL + DB, multi-service flows)
- **e2e/** — End-to-end user flows (e.g. Playwright/Cypress against studio app)
- **fixtures/** — Shared test data, wire mock configs, test env setup

## When to run

- After: `git submodule update --init --recursive`
- From repo root: `./scripts/test-integration.sh` and `./scripts/test-e2e.sh` (when added)
- CI: Parent workflow checks out submodules, builds, then runs these tests

## Unit and in-repo tests

Unit and in-repo integration tests live **inside each repo**: in **platform/** (e.g. platform/contracts/tests/, platform/services/tests/) and in **studio-portal/** (e.g. studio-portal/studio/tests/). See [docs/TESTING.md](docs/TESTING.md).
