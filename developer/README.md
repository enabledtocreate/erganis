# Erganis Developer Module

Standalone Erganis module for **pipeline debugging**, **ID link introspection**, and **contract discovery**.

> **Not shipped by default.** This package is intended as its own git repository (`erganis-developer`). Core discovers it via `MODULES_EXTRA_ROOTS` when present locally. Enable per org in **Admin → Modules**.

## Purpose

- View installed modules, surfaces, and operation pipeline steps
- See how `publicId` values connect across modules (projects ↔ inventory ↔ rooms)
- Inspect link types (reference, assignment, membership) and live org data
- Reference platform JSON Schema contract paths

## Local setup

```bash
cd developer
npm install
npm run build
```

In `core/services/.env`:

```env
MODULES_EXTRA_ROOTS=../../developer
```

Restart Core, then enable **Developer** in Studio Admin → Modules.

## Surfaces

| Surface | Action | Handler |
|---------|--------|---------|
| `developer` | `load` | `loadDeveloperGraph` |

Studio route: `/developer` (visible when module is enabled for the org).

## Publishing

When split to its own repo, add as a git submodule or install path:

```bash
git submodule add https://github.com/enabledtocreate/erganis-developer developer
```

Point `MODULES_EXTRA_ROOTS` at the checkout path on each Core instance.
