# Dev scripts

Run from the **erganis (parent) repo root**.

| Script | Purpose |
|--------|--------|
| **setup-local.sh** | Start Postgres + Redis (from platform), npm install in platform/contracts, platform/services, platform/packages, studio-portal. |
| **setup-local.ps1** | Windows: same as above. |

```bash
./scripts/dev/setup-local.sh
# or Windows: .\scripts\dev\setup-local.ps1
```

Ensure Docker is running first.
