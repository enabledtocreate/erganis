# Erganis — GitHub repo setup

Use this guide to create the GitHub repositories and wire the **two sub-repos** as submodules.

## 0. Enable repo creation (one-time)

### Option A: GitHub CLI (recommended)

1. **Install GitHub CLI** — [cli.github.com](https://cli.github.com/) or `winget install GitHub.cli` / `brew install gh`
2. **Log in:** `gh auth login` (sign in as **enabledtocreate**)
3. **Create repos** — From the `erganis` folder:
   ```powershell
   .\scripts\create-repos.ps1
   ```
   Or: `./scripts/create-repos.sh`  
   This creates **3** public repos: `erganis`, `erganis-platform`, `erganis-app-studio-portal`. Existing repos are skipped.

### Option B: Create repos manually

On [github.com/new](https://github.com/new), create under **enabledtocreate** (no README, no .gitignore):

| Repo name | Purpose |
|-----------|---------|
| `erganis` | Parent meta-repo |
| `erganis-platform` | Contracts, infrastructure, services, packages, scripts (one repo) |
| `erganis-app-studio-portal` | Studio and client portal (one repo, two folders) |

---

## 1. Push parent repo first

```bash
cd erganis
git init
git add .
git commit -m "Initial structure and README"
git remote add origin https://github.com/enabledtocreate/erganis.git
git branch -M main
git push -u origin main
```

## 2. Push platform sub-repo

The `platform/` folder contains contracts, infrastructure, services, packages, scripts. Push it as its own repo:

```bash
cd erganis/platform
git init
git add .
git commit -m "Initial platform (contracts, infrastructure, services, packages, scripts)"
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

## 4. Add submodules to parent (optional)

If you want the parent to track `platform/` and `studio-portal/` as submodules (so `git clone --recurse-submodules erganis` gets both):

```bash
cd erganis
git rm -r --cached platform studio-portal
git commit -m "Remove subdirs before adding as submodules"
git submodule add https://github.com/enabledtocreate/erganis-platform.git platform
git submodule add https://github.com/enabledtocreate/erganis-app-studio-portal.git studio-portal
git add .gitmodules platform studio-portal
git commit -m "Add submodules"
git push
```

After this, the parent only tracks commits of each submodule.
