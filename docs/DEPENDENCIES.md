# Erganis — Dependency strategy

## Summary

- **Platform (one repo):** contracts, infrastructure, services, packages, scripts live in **erganis-platform**; use **relative paths** between folders. They evolve together.
- **Apps:** Depend only on the **API layer**. Consume via live URL (e.g. OpenAPI YAML/JSON) or generated client/SDK. No direct repo references to services or infrastructure.
- **Packages:** Shared utilities; referenced via relative path when using full platform clone.

## How repos reference each other

**Inside platform (one repo):** Use relative paths (e.g. `contracts/schemas/`, `../infrastructure/dal/`).

| Repo / folder | Depends on | How |
|---------------|------------|-----|
| **platform/contracts** | — | Standalone |
| **platform/infrastructure** | platform/contracts | Relative path |
| **platform/services** | platform/contracts, platform/infrastructure, platform/packages | Relative paths |
| **platform/packages** | platform/contracts (optional) | Relative path |
| **studio-portal** (app repo) | API (from platform) | Live URL or generated SDK; no direct reference to platform repo |

## Cloning

- **Full platform:** `git clone --recurse-submodules https://github.com/enabledtocreate/erganis.git` — you get parent + platform + studio-portal.
- **Platform only:** `git clone https://github.com/enabledtocreate/erganis-platform.git` — backend only; all platform folders use relative paths.
- **App only:** `git clone https://github.com/enabledtocreate/erganis-app-studio-portal.git` — app consumes API via URL or SDK.

## API: internal vs public

- **Core API** is defined in `platform/contracts/schemas/core/openapi.yaml` (or inside platform repo: `contracts/schemas/core/openapi.yaml`).
- **Public API** is a generated subset (operations with `x-audience: public`) in `contracts/schemas/public/v1/`, `v2/`, etc.
- Apps and third parties consume the API via URL or generated client; internal services use the full core.

See [platform/contracts/schemas/README.md](../platform/contracts/schemas/README.md) for generation and support policy.
