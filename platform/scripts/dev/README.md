# Dev scripts

Run from the **erganis repo root** (parent repo).

| Script | Purpose |
|--------|--------|
| **setup-local.sh** | Linux/macOS: start Postgres + Redis, init submodules, npm install in contracts/studio-portal/services/packages. |
| **setup-local.ps1** | Windows: same as above. |

```bash
# From erganis root
./scripts/dev/setup-local.sh
# or on Windows (PowerShell):
.\scripts\dev\setup-local.ps1
```

Ensure Docker is running before executing.
