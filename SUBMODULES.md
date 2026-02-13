# Working with Erganis submodules

The parent **erganis** repo has **two submodules**:

- **platform/** — `erganis-platform` (contracts, infrastructure, services, packages, scripts)
- **studio-portal/** — `erganis-app-studio-portal` (studio, client-portal, shared)

## Why submodules?

- **Platform** and **apps** can be cloned and used on their own.
- The parent references specific commits of each so that `git clone --recurse-submodules erganis` gives a known-good set.

## Common commands

```bash
# From the erganis root:
git submodule update --init --recursive   # First-time or after clone without --recurse-submodules
git submodule update --remote             # Update each submodule to latest of its tracked branch
git submodule status                      # See current commit of each submodule
```

## Pushing changes in a submodule

1. `cd` into the submodule (e.g. `platform/` or `studio-portal/`).
2. Commit and push there: `git add ...`, `git commit`, `git push`.
3. From the **erganis** root, the parent will see the submodule as modified. Commit that change in the parent and push so the parent points to the new submodule commit.

## Adding a new sub-repo

1. Create the repo on GitHub under `enabledtocreate`.
2. From the erganis root:  
   `git submodule add https://github.com/enabledtocreate/<repo-name>.git <path>`  
   e.g. `git submodule add https://github.com/enabledtocreate/erganis-app-mobile.git mobile-app`
3. Commit the new `.gitmodules` and `<path>` entry in the parent repo.
