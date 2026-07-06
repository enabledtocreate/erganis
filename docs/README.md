# Erganis Platform Documentation

## Product planning

- [erganis-product-plan.md](erganis-product-plan.md) — **Primary planning document** (vision, architecture, stack, modules, backlog, open questions)
- [IMPLEMENTATION-PLANS.md](IMPLEMENTATION-PLANS.md) — **Consolidated delivery plans** per repo (Core C0–C16, UI, Studio S*, Agora, Companion, Lyceum)

## Per-project implementation plans

| Project | Plan |
|---------|------|
| Core | [`core/docs/temp/CORE-IMPLEMENTATION-PLAN.md`](../core/docs/temp/CORE-IMPLEMENTATION-PLAN.md) |
| Studio | [`studio/docs/STUDIO-IMPLEMENTATION-PLAN.md`](../studio/docs/STUDIO-IMPLEMENTATION-PLAN.md) |
| Agora | [`agora/docs/AGORA-IMPLEMENTATION-PLAN.md`](../agora/docs/AGORA-IMPLEMENTATION-PLAN.md) |
| Companion | [`companion/docs/COMPANION-IMPLEMENTATION-PLAN.md`](../companion/docs/COMPANION-IMPLEMENTATION-PLAN.md) |
| Lyceum | [`lyceum/docs/LYCEUM-IMPLEMENTATION-PLAN.md`](../lyceum/docs/LYCEUM-IMPLEMENTATION-PLAN.md) |
| erganis-ui | [`ui/docs/UI-ARCHITECTURE.md`](../ui/docs/UI-ARCHITECTURE.md) |

## Per-project documentation (temporary)

Until APM generates managed docs per repo, each **submodule** has a local staging area:

| Repo | Path |
|------|------|
| Core | `core/docs/temp/` |
| Studio | `studio/docs/temp/` |
| Agora | `agora/docs/temp/` |
| Companion | `companion/docs/temp/` |
| Lyceum | `lyceum/docs/temp/` |
| erganis-ui | `ui/docs/` |

Use these for drafts, ADRs, and implementation notes. Promote content via APM when templates are in use — do not treat `temp/` as long-term source of truth.

## Development

- [DEPENDENCIES.md](DEPENDENCIES.md) — Repo references and API consumption
- [SUBMODULES.md](SUBMODULES.md) — Submodule workflow (clone, push, add)
- [TESTING.md](TESTING.md) — Testing strategy
- [GITHUB-SETUP.md](GITHUB-SETUP.md) — GitHub repos and submodules
- [CONTRIBUTING.md](CONTRIBUTING.md) — Contribution guidelines

## Planning and governance

- [SUGGESTIONS.md](SUGGESTIONS.md) — Structural improvement backlog (build/process)
- [SECURITY.md](../SECURITY.md) — Security policy (root file; required by GitHub)

## Related

- Parent: [erganis](https://github.com/enabledtocreate/erganis)
- Sub-repos: `erganis-core`, `erganis-studio`, `erganis-agora`, `erganis-companion`, `erganis-lyceum`, `erganis-ui` *(planned)*
