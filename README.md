# Erganis

*Erganis* — a play on Athena's epithet *Ἐργάνη* (Ergane, "the Industrious") — is an open-source platform initially for interior designers, with the goal of extending to the broader build environment.

This repository is the **parent** (meta) repo. It ties together the following sub-repositories. Each can be used **on its own** or as part of the full platform.

## Two ways to get the code

**Full platform** — clone the parent and all submodules in one go:

```bash
git clone --recurse-submodules https://github.com/enabledtocreate/erganis.git
cd erganis
```

**Single project** — clone only what you need:

```bash
# Platform (contracts, services, infrastructure, packages, scripts)
git clone https://github.com/enabledtocreate/erganis-platform.git
cd erganis-platform

# Or just the app
git clone https://github.com/enabledtocreate/erganis-app-studio-portal.git
cd erganis-app-studio-portal
```

The parent ties together **two sub-repos**; each can be used on its own.

## Repository structure (two sub-repos)

| Sub-repo | Contents | Purpose |
|----------|----------|---------|
| [erganis-platform](platform/) | contracts, infrastructure, services, packages, scripts | Backend: API contracts, DAL, services, shared libs, tooling |
| [erganis-app-studio-portal](studio-portal/) | studio, client-portal, shared | Presentation: designer studio and client portal (one repo, two app folders) |

The parent also holds [.github](.github/) (CI/CD), [docs](docs/), [tests](tests/), and [scripts](scripts/) that orchestrate the full platform.

## Architecture overview

```
┌─────────────────────────────────────────┐
│  APPS (studio-portal)                   │
│  studio/ + client-portal/ + shared/     │
│  + future app repos (mobile, desktop…)  │
└──────────────┬──────────────────────────┘
               │ Consumes API only (URL or SDK)
               ▼
┌─────────────────────────────────────────┐
│  PLATFORM (one repo)                     │
│  contracts → infrastructure → services   │
│  packages, scripts                       │
└─────────────────────────────────────────┘
```

## GitHub organization

- **Account:** [enabledtocreate](https://github.com/enabledtocreate)
- Repos: `erganis` (parent), `erganis-platform`, `erganis-app-studio-portal`

## Cloning with submodules (full platform)

If you already cloned the parent **without** submodules:

```bash
git submodule update --init --recursive
```

## Adding submodules (after creating GitHub repos)

From the root of `erganis`:

```bash
git submodule add https://github.com/enabledtocreate/erganis-platform.git platform
git submodule add https://github.com/enabledtocreate/erganis-app-studio-portal.git studio-portal
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

See [docs/CONTRIBUTING.md](docs/CONTRIBUTING.md) for contribution guidelines.

## Security

See [SECURITY.md](SECURITY.md) for security policy and vulnerability reporting.
