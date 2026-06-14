# Working with Erganis submodules

The parent **erganis** repo (Erganis Platform) has **four submodules**:

- **core/** — `erganis-core` (contracts, data, infrastructure, services, packages, scripts)
- **studio/** — `erganis-studio` (apps/studio, apps/client, modules/, shared/)
- **agora/** — `erganis-agora` (web/, api/, shared/)
- **companion/** — `erganis-companion` (mobile app)

## Why submodules?

- **Core**, **Studio**, **Agora**, and **Companion** can be cloned and used on their own.
- The parent references specific commits so `git clone --recurse-submodules erganis` gives a known-good set.

## Common commands

```bash
git submodule update --init --recursive
git submodule update --remote
git submodule status
```

## Pushing changes in a submodule

1. `cd` into the submodule (e.g. `core/`, `studio/`, `agora/`, or `companion/`).
2. Commit and push there.
3. From the **erganis** root, commit the updated submodule pointer and push.

## Adding a new sub-repo

1. Create the repo on GitHub under `enabledtocreate`.
2. `git submodule add https://github.com/enabledtocreate/<repo-name>.git <path>`
3. Commit `.gitmodules` and the path entry in the parent repo.
