# Erganis — Architecture Overview

Erganis uses a **parent + three sub-repos** model with N-tier layering inside the platform.

## Three sub-repos

### 1. **erganis-platform** (path: `platform/`)

One repo containing the **tightly coupled backend** (all of these are folders, not submodules):

| Folder | Tier | Purpose |
|--------|------|---------|
| **contracts/** | Contracts | Schemas, core + public API, SDK generation |
| **data/** | Data | DAL, migrations, SQL |
| **infrastructure/** | Runtime & Deploy | Docker, deployment (IaC) |
| **services/** | Application | API gateway, business logic, background jobs |
| **packages/** | Shared | UI libs, logging, auth, utils |
| **scripts/** | Tooling | Setup, deploy, dev, maintenance |

Use **relative paths** between these folders. They evolve together.

### 2. **erganis-app-studio-portal** (path: `studio-portal/`)

Presentation tier — one repo, two app folders:

- **studio/** — Designer studio application
- **client-portal/** — Client-facing portal
- **shared/** — Shared UI and API clients

**Apps consume only the API** (live URL or generated SDK).

### 3. **erganis-app-id-companion** (path: `id-companion/`)

Mobile app — one repo:

- **app/** — Main mobile application (screens, navigation)
- **shared/** — Shared logic, API client, utilities

## Data flow

```
studio-portal, id-companion (apps)
  ↓ Consume API only (URL or SDK)
platform/
  ├── contracts (API surface)
  ├── data (DAL, migrations, SQL)
  ├── infrastructure (Docker, deployment)
  ├── services (business logic, uses data layer)
  ├── packages (shared libs)
  └── scripts (automation)
```

## Parent repo (erganis)

Holds **docs/**, **tests/** (integration, e2e), **scripts/** (orchestration), **.github/** (CI). Submodules: `platform/`, `studio-portal/`, `id-companion/`.

## Technology flexibility

- **Platform** can mix .NET, Node, Java, etc. per folder.
- **Apps** can be React, Vue, mobile, desktop. Each app repo chooses its stack.
