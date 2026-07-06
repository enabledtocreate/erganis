# Working with Erganis submodules

The parent **erganis** repo (Erganis Platform) has **five submodules** (plus **`ui/`** scaffold — add as submodule when `erganis-ui` GitHub repo is created):

- **core/** — `erganis-core` (contracts, data, infrastructure, services, packages, scripts)
- **studio/** — `erganis-studio` (apps/studio, apps/client, modules/, shared/)
- **agora/** — `erganis-agora` (web/, api/, shared/)
- **companion/** — `erganis-companion` (mobile app)
- **lyceum/** — `erganis-lyceum` (Mnemosyne + Nomodeion study products)
- **ui/** — `erganis-ui` *(documentation scaffold in parent; GitHub repo when C16/UI0 starts — TypeScript packages only in v1)*

## Why submodules?

- **Core**, **Studio**, **Agora**, **Companion**, **Lyceum**, and **UI** can be cloned and used on their own.
- The parent references specific commits so `git clone --recurse-submodules erganis` gives a known-good set.

## Common commands

```bash
git submodule update --init --recursive
git submodule update --remote
git submodule status
```

## Pushing changes in a submodule

1. `cd` into the submodule (e.g. `core/`, `studio/`, `ui/`).
2. Commit and push there.
3. From the **erganis** root, commit the updated submodule pointer and push.

## Adding a new sub-repo

1. Create the repo on GitHub under `enabledtocreate`.
2. `git submodule add https://github.com/enabledtocreate/<repo-name>.git <path>`
3. Commit `.gitmodules` and the path entry in the parent repo.

### Adding erganis-ui (when C16 / UI0 starts)

Create the repo only when implementing TypeScript UI packages — **not** as part of initial Core work:

```bash
gh repo create enabledtocreate/erganis-ui --public --description "Erganis UI: TypeScript composition libraries (ui-react, ui-shadcn)"
git submodule add https://github.com/enabledtocreate/erganis-ui.git ui
```

v1 scope: `@erganis/ui-contracts`, `@erganis/ui-react`, `@erganis/ui-shadcn` only. MAUI (`ui-maui`) and RN (`ui-native`) stay documented — no GitHub packages until UI5/UI6.

See [`ui/docs/UI-ARCHITECTURE.md`](../ui/docs/UI-ARCHITECTURE.md).
