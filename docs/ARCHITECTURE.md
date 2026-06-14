# Erganis Platform — Architecture Overview

Erganis Platform uses a **parent + four sub-repos** model. **Core** is the universal foundation for Studio, Agora, and Companion.

## Four sub-repos

### 1. **erganis-core** (path: `core/`)

Tightly coupled backend (folders, not nested submodules):

| Folder | Purpose |
|--------|---------|
| **contracts/** | OpenAPI schemas, SDK generation (`contracts/sdk/`) |
| **data/** | DAL, migrations, SQL |
| **infrastructure/** | Deploy templates; Docker optional |
| **services/** | NestJS Core runtime, orchestrator, pg-boss |
| **packages/** | Shared TS libraries |
| **scripts/** | Setup, migrate, update CLI |

### 2. **erganis-studio** (path: `studio/`)

```
studio/
├── apps/studio/       # designer app
├── apps/client/       # client portal
├── modules/           # first-party plugins
├── modules/third-party/
└── shared/
```

Apps consume **Core Surface API** (URL or generated SDK).

### 3. **erganis-agora** (path: `agora/`)

- **web/** — public vendor search (MapLibre)
- **api/** — NestJS + Agora PostgreSQL (global catalog)
- **shared/** — types aligned with Core contracts

Sync jobs connect Agora API with Core. Studio **Agora plugin** (`studio/modules/agora`) handles org trade tracking.

### 4. **erganis-companion** (path: `companion/`)

Mobile app consuming **Core Public API**.

## Data flow

```
studio/apps/*, companion/app  →  Core Surface/Public API  →  Core PostgreSQL
agora/web                     →  Agora API                 →  Agora PostgreSQL
Core ↔ Agora                  →  sync jobs (pg-boss)
```

## Parent repo (erganis)

Holds **docs/**, **tests/**, **scripts/**, **.github/**. Submodules: `core/`, `studio/`, `agora/`, `companion/`.

## Stack

NestJS, PostgreSQL, pg-boss, React/Next.js, MapLibre. See [STACK.md](STACK.md) and [erganis_architecture_spec.md](erganis_architecture_spec.md).
