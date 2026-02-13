# Erganis — Architecture Overview

Erganis uses a **parent + two sub-repos** model with N-tier layering inside the platform.

## Two sub-repos

### 1. **erganis-platform** (path: `platform/`)

One repo containing the **tightly coupled backend** (all of these are folders, not submodules):

| Folder | Tier | Purpose |
|--------|------|---------|
| **contracts/** | Contracts | Schemas, core + public API, SDK generation |
| **infrastructure/** | Data & Env | DAL, migrations, SQL, Docker, deployment |
| **services/** | Application | API gateway, business logic, background jobs |
| **packages/** | Shared | UI libs, logging, auth, utils |
| **scripts/** | Tooling | Setup, deploy, dev, maintenance |

Use **relative paths** between these folders. They evolve together.

### 2. **erganis-app-studio-portal** (path: `studio-portal/`)

Presentation tier — one repo, two app folders:

- **studio/** — Designer studio application
- **client-portal/** — Client-facing portal
- **shared/** — Shared UI and API clients

**Apps consume only the API** (live URL or generated SDK). Future apps (mobile, desktop) can be additional repos.

## Data flow

```
studio-portal (apps)
  ↓ Consumes API only (URL or SDK)
platform/
  ├── contracts (API surface)
  ├── services (business logic, uses DAL)
  ├── infrastructure (DAL, migrations, Docker)
  ├── packages (shared libs)
  └── scripts (automation)
```

## Parent repo (erganis)

Holds **docs/**, **tests/** (integration, e2e), **scripts/** (orchestration), **.github/** (CI). Submodules: `platform/` and `studio-portal/`.

## Technology flexibility

- **Platform** can mix .NET, Node, Java, etc. per folder.
- **Apps** can be React, Vue, mobile, desktop. Each app repo chooses its stack.
