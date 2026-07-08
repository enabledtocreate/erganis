# Erganis — Dependency strategy

## Summary

- **Core (`erganis-core`):** contracts, data, infrastructure, services, packages, scripts — **relative paths** between folders.
- **Studio, Agora, Companion:** depend on **API contracts / SDKs**, not direct Core repo paths (except monorepo dev with submodules).
- **Agora API:** separate deploy; shares vendor schema shapes via Core contracts; sync jobs align data.

## How repos reference each other

**Inside Core:**

| Folder | Depends on | How |
|--------|------------|-----|
| **contracts** | — | OpenAPI source; SDK output in `contracts/sdk/` |
| **data** | contracts (optional) | Relative path |
| **services** | contracts, data, packages | Relative paths; NestJS |
| **packages** | contracts (optional) | Relative path |

**App repos:**

| Repo | Depends on | How |
|------|------------|-----|
| **studio** | Core API | Surface API URL or `@erganis/sdk` |
| **notes** | Core contracts, `@erganis/platform` | Module loaded by Core; contracts in `notes/contracts/` |
| **agora** | Core contracts (types), Agora API | Shared schemas; web → agora/api |
| **companion** | Core API | Public API URL or SDK subset |
| **lyceum** | Core API, **erganis-notes** (when enabled) | Study Surfaces + shared Notes module |

## Cloning

- **Full platform:** `git clone --recurse-submodules …/erganis.git`
- **Core only:** `git clone …/erganis-core.git`
- **Notes only:** `git clone …/erganis-notes.git`
- **Single app:** `erganis-studio`, `erganis-notes`, `erganis-agora`, or `erganis-companion`

## API: internal vs public

- **Core API:** `core/contracts/schemas/core/openapi.yaml`
- **Public API:** generated subset in `schemas/public/v1/`, etc.
- **Agora API:** separate OpenAPI in `agora/api/` extending Core vendor components

See [core/contracts/schemas/README.md](../core/contracts/schemas/README.md).
