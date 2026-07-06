# Erganis UI (`erganis-ui`)

**TypeScript UI composition libraries** — contract-first bindings from Core APIs to React/Shadcn components.

> **GitHub:** Create `erganis-ui` when **C16 / UI0** starts — **not** before Core implementation work.  
> **Architecture:** [`docs/UI-ARCHITECTURE.md`](docs/UI-ARCHITECTURE.md) · **Layout schemas:** [`core/contracts/schemas/composition/`](../core/contracts/schemas/composition/README.md)

## v1 scope (TypeScript only)

**In scope for the first GitHub repo and packages:**

| Package | Purpose |
|---------|---------|
| `@erganis/ui-contracts` | Types from JSON Schema (`ui-layout`, theme, slots) |
| `@erganis/ui-react` | Headless hooks — `useSurfaceLoad`, `useTheme`, `useOperation`, layout renderer |
| `@erganis/ui-shadcn` | Reference web design system (Shell, SlotOutlet, ThemeProvider) |

**Documented only (no repo/packages until needed):**

| Package | When |
|---------|------|
| `@erganis/ui-native` | Companion RN (UI5) |
| `@erganis/ui-maui` | .NET MAUI + XAML (UI6) |

## Layout contracts (module developers)

Module developers control UI layout via:

1. **`contributions.ui`** in manifest — component → platform slot
2. **`contributions.layout`** — path to `*.layout.json` validated against [`ui-layout.schema.json`](../core/contracts/schemas/composition/ui-layout.schema.json)
3. **React components** — implement regions referenced in layout JSON

OpenAPI covers HTTP; **JSON Schema in `core/contracts/schemas/composition/`** covers UI structure.

## Status

**Documentation scaffold** in parent monorepo (`ui/`). Submodule + GitHub repo when C16 implementation begins.

## Consumers (v1)

Studio, Client portal, Lyceum web → `ui-react` + `ui-shadcn`.
