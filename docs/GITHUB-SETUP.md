# Erganis — GitHub repo setup

The **parent repo** [erganis](https://github.com/enabledtocreate/erganis) is the Erganis Platform meta repo. Sub-repos:

| Repo | Path | Purpose |
|------|------|---------|
| `erganis-core` | `core/` | Core runtime |
| `erganis-studio` | `studio/` | Studio + client apps, modules |
| `erganis-agora` | `agora/` | Public vendor site + API |
| `erganis-companion` | `companion/` | Mobile app |

Legacy names (`erganis-platform`, `erganis-app-studio-portal`, `erganis-app-id-companion`) should be renamed or replaced on GitHub when migrating.

## Create sub-repos (one-time)

### GitHub CLI

```powershell
.\scripts\create-repos.ps1
```

Or `./scripts/create-repos.sh`

### Push local folders to GitHub

```powershell
.\scripts\push-subrepos.ps1
```

Run from erganis root. Creates repos if missing and pushes `core/`, `studio/`, `agora/`, `companion/`.

## Add as submodules

```bash
cd erganis
git submodule add https://github.com/enabledtocreate/erganis-core.git core
git submodule add https://github.com/enabledtocreate/erganis-studio.git studio
git submodule add https://github.com/enabledtocreate/erganis-agora.git agora
git submodule add https://github.com/enabledtocreate/erganis-companion.git companion
git commit -m "Add submodules: core, studio, agora, companion"
```

See [SUBMODULES.md](../SUBMODULES.md) for day-to-day submodule workflow.
