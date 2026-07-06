# Erganis — GitHub repo setup

The **parent repo** [erganis](https://github.com/enabledtocreate/erganis) is the Erganis Platform meta repo. Sub-repos:

| Repo | Path | Purpose |
|------|------|---------|
| `erganis-core` | `core/` | Core runtime |
| `erganis-studio` | `studio/` | Studio + client apps, modules |
| `erganis-agora` | `agora/` | Public vendor site + API |
| `erganis-companion` | `companion/` | Mobile app |
| `erganis-lyceum` | `lyceum/` | Lyceum — Mnemosyne + Nomodeion |
| `erganis-ui` | `ui/` | TypeScript UI libs — **create repo at C16/UI0** (not in `create-repos.ps1` yet) |

Legacy names (`erganis-platform`, `erganis-app-studio-portal`, `erganis-app-id-companion`) should be renamed or replaced on GitHub when migrating.

**Not in `create-repos.ps1`:** `erganis-ui` — deferred until Core C16 / UI0 (TypeScript-only v1). MAUI and React Native packages are documented only.

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

Run from erganis root. Creates repos if missing and pushes `core/`, `studio/`, `agora/`, `companion/`, `lyceum/`.

## Add as submodules

```bash
cd erganis
git submodule add https://github.com/enabledtocreate/erganis-core.git core
git submodule add https://github.com/enabledtocreate/erganis-studio.git studio
git submodule add https://github.com/enabledtocreate/erganis-agora.git agora
git submodule add https://github.com/enabledtocreate/erganis-companion.git companion
git submodule add https://github.com/enabledtocreate/erganis-lyceum.git lyceum
git commit -m "Add submodules: core, studio, agora, companion, lyceum"
```

See [SUBMODULES.md](SUBMODULES.md) for day-to-day submodule workflow.
