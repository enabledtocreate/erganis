# Erganis — GitHub repo setup

The **parent repo** [erganis](https://github.com/enabledtocreate/erganis) already exists. This guide is for **migrating** to the new structure: archive old repos, create the two new sub-repos, then wire them as submodules.

## Migration: old repos → new structure

| Action | Repos |
|--------|--------|
| **Keep** | `enabledtocreate/erganis` (parent) |
| **Archive** (then optionally delete) | `erganis-stack`, `erganis-docs`, `erganis-database`, `erganis-backend`, `erganis-frontend`, `erganis-api`, `erganis-contracts` |
| **Create** | `erganis-platform`, `erganis-app-studio-portal` |

- **Archive** (read-only, reversible):  
  `.\scripts\archive-old-repos.ps1` or `./scripts/archive-old-repos.sh`
- **Delete** (permanent):  
  `.\scripts\delete-old-repos.ps1` or `./scripts/delete-old-repos.sh`  
  Requires delete scope: `gh auth refresh -s delete_repo`. You’ll be asked to type `yes` to confirm.
- **Create the two new sub-repos and push** `platform/` and `studio-portal/` so they appear as separate GitHub repos:  
  `.\scripts\push-subrepos.ps1` or `./scripts/push-subrepos.sh`  
  Run from the erganis repo root. This creates **erganis-platform** and **erganis-app-studio-portal** if they don’t exist, then pushes the contents of `platform/` and `studio-portal/` to them.

---

## 0. Create the two new sub-repos (one-time)

You only need to create **erganis-platform** and **erganis-app-studio-portal**. The parent **erganis** already exists.

### Option A: GitHub CLI (recommended)

1. **Install GitHub CLI** — [cli.github.com](https://cli.github.com/) or `winget install GitHub.cli` / `brew install gh`
2. **Log in:** `gh auth login` (sign in as **enabledtocreate**)
3. **Create the two new repos** — From the `erganis` folder:
   ```powershell
   .\scripts\create-repos.ps1
   ```
   Or: `./scripts/create-repos.sh`  
   This creates only **erganis-platform** and **erganis-app-studio-portal**. Existing repos are skipped.

### Option B: Create repos manually

On [github.com/new](https://github.com/new), create under **enabledtocreate** (no README, no .gitignore):

| Repo name | Purpose |
|-----------|---------|
| `erganis-platform` | Contracts, data (DAL/migrations/SQL), infrastructure (Docker/deploy), services, packages, scripts (one repo) |
| `erganis-app-studio-portal` | Studio and client portal (one repo, two folders) |

---

## 1. Push updated parent repo

Your local `erganis` has the new layout (platform/, studio-portal/). Push to the existing **erganis** repo:

```bash
cd erganis
git remote add origin https://github.com/enabledtocreate/erganis.git
# If you already have origin, skip the line above
git branch -M main
git push -u origin main
```

If the repo already had a different structure, resolve any conflicts; the goal is for `main` to contain the new parent layout (docs, scripts, .github, platform/, studio-portal/).

## 2. Push platform sub-repo

The `platform/` folder contains contracts, data, infrastructure, services, packages, scripts. Push it as its own repo:

```bash
cd erganis/platform
git init
git add .
git commit -m "Initial platform (contracts, data, infrastructure, services, packages, scripts)"
git remote add origin https://github.com/enabledtocreate/erganis-platform.git
git branch -M main
git push -u origin main
cd ..
```

## 3. Push studio-portal sub-repo

```bash
cd erganis/studio-portal
git init
git add .
git commit -m "Initial studio and client portal"
git remote add origin https://github.com/enabledtocreate/erganis-app-studio-portal.git
git branch -M main
git push -u origin main
cd ..
```

## 4. Switch to submodules (optional)

If you want the parent to track `platform/` and `studio-portal/` as submodules (so `git clone --recurse-submodules erganis` gets both), remove the folders from the index and add them as submodules. If the parent previously had other submodules, remove those first (e.g. `git submodule deinit <path>`, `git rm <path>`), then add the new ones:

```bash
cd erganis
git rm -r --cached platform studio-portal
git commit -m "Remove subdirs before adding as submodules"
git submodule add https://github.com/enabledtocreate/erganis-platform.git platform
git submodule add https://github.com/enabledtocreate/erganis-app-studio-portal.git studio-portal
git add .gitmodules platform studio-portal
git commit -m "Add submodules: platform, studio-portal"
git push
```

After this, the parent only tracks commits of each submodule.
