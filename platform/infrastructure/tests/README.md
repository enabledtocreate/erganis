# Infrastructure tests

Unit and in-repo integration tests for infrastructure (DAL, migrations, SQL).

- **DAL tests** — Mocked DB or test container.
- **Migration tests** — Validate migration scripts (e.g. dry-run or against test DB).

Cross-repo integration (e.g. services + DAL + DB) lives in the **parent** repo: `erganis/tests/integration/`.  
See [docs/TESTING.md](../../docs/TESTING.md) in the parent repo.
