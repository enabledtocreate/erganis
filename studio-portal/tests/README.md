# Studio-portal tests

Unit and in-repo integration tests for **studio** and **client-portal**.

- **studio/tests/** or co-located `studio/**/*.test.*` — Studio app tests
- **client-portal/tests/** or co-located — Client portal tests
- **shared/tests/** — Shared code tests

Use the standard tool for the stack (e.g. Vitest, Jest).  
Cross-repo integration and E2E tests live in the **parent** repo: `erganis/tests/integration/` and `erganis/tests/e2e/`.

See [docs/TESTING.md](../../docs/TESTING.md) in the parent repo.
