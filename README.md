# Erganis Platform

*Erganis* — a play on Athena's epithet *Ἐργάνη* (Ergane, "the Industrious") — is an open-source platform initially for interior designers, with the goal of extending to the broader build environment.

This repository is the **parent** (meta) repo for the **Erganis Platform**. It ties together sub-repositories. Each can be used **on its own** or as part of the full platform.

## Two ways to get the code

**Full platform** — clone the parent and all submodules:

```bash
git clone --recurse-submodules https://github.com/enabledtocreate/erganis.git
cd erganis
```

**Single project** — clone only what you need:

```bash
# Core (contracts, data, infrastructure, services, packages, scripts)
git clone https://github.com/enabledtocreate/erganis-core.git
cd erganis-core

# Studio (designer + client apps, modules)
git clone https://github.com/enabledtocreate/erganis-studio.git
cd erganis-studio

# Erganis Agora (public vendor site)
git clone https://github.com/enabledtocreate/erganis-agora.git
cd erganis-agora

# Companion mobile app
git clone https://github.com/enabledtocreate/erganis-companion.git
cd erganis-companion
```

The parent ties together **four sub-repos**; each can be used on its own.

## Repository structure

| Sub-repo | Path | Purpose |
|----------|------|---------|
| [erganis-core](core/) | `core/` | Core runtime: contracts, SDKs, data, Nest services, packages, scripts |
| [erganis-studio](studio/) | `studio/` | `apps/studio`, `apps/client`, `modules/`, `shared/` |
| [erganis-agora](agora/) | `agora/` | Public vendor catalog: `web/`, `api/`, `shared/` |
| [erganis-companion](companion/) | `companion/` | Mobile companion app |

The parent also holds [.github](.github/) (CI/CD), [docs](docs/), [tests](tests/), and [scripts](scripts/).

## Architecture overview

```
┌──────────────────────────────────────────────────┐
│  APPS                                            │
│  studio (apps/studio + apps/client + modules)    │
│  agora (public web)                              │
│  companion (mobile)                              │
└──────────────┬───────────────────────────────────┘
               │ API / SDK
               ▼
┌──────────────────────────────────────────────────┐
│  CORE (erganis-core)                             │
│  contracts → data → services → packages          │
│  orchestrator, jobs, identity                    │
└──────────────────────────────────────────────────┘
         ↔ sync jobs ↔
┌──────────────────────────────────────────────────┐
│  AGORA API (separate PostgreSQL)                 │
└──────────────────────────────────────────────────┘
```

See [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) and [docs/STACK.md](docs/STACK.md).

## GitHub organization

- **Account:** [enabledtocreate](https://github.com/enabledtocreate)
- **Parent:** [erganis](https://github.com/enabledtocreate/erganis)
- **Sub-repos:** `erganis-core`, `erganis-studio`, `erganis-agora`, `erganis-companion`

## Cloning with submodules

If you already cloned without submodules:

```bash
git submodule update --init --recursive
```

## Adding submodules

From the root of `erganis`:

```bash
git submodule add https://github.com/enabledtocreate/erganis-core.git core
git submodule add https://github.com/enabledtocreate/erganis-studio.git studio
git submodule add https://github.com/enabledtocreate/erganis-agora.git agora
git submodule add https://github.com/enabledtocreate/erganis-companion.git companion
```

## License

MIT License — see [LICENSE](LICENSE).

## Contributing

See [docs/CONTRIBUTING.md](docs/CONTRIBUTING.md).

## Security

See [SECURITY.md](SECURITY.md).
