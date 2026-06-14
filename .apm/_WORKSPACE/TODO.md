# APM Workspace TODO

Volatile scratch pad for AI working files: TODOs, open questions, draft plans, and temporary notes.

**Ideas backlog:** [IDEAS.md](./IDEAS.md)

---

## Resolved Decisions (2025-06)

See [IDEAS.md](./IDEAS.md) and [docs/erganis_architecture_spec.md](../../docs/erganis_architecture_spec.md) for full detail.

| Area | Decision |
|------|----------|
| Ecosystem | **Erganis Platform** |
| Base layer | **Core** (`core/`, repo `erganis-core`) |
| Submodules | `core/`, `studio/`, `agora/`, `companion/` |
| Studio apps | `apps/studio/`, `apps/client/`; modules in `modules/`; 3rd-party in `modules/third-party/` |
| Public vendor site | **Erganis Agora** (not "marketplace" in UX); optional "guild" as domain term |
| Agora architecture | Separate Agora API + DB; sync jobs with Core; Studio Agora plugin for org trade tracking |
| Trade accounts | Manual tracking in Studio plugin; Documents plugin; background match from global Agora |
| Manifest | YAML authoring → JSON runtime |
| Stack | NestJS, PostgreSQL, pg-boss, LocalFileStore v1, MapLibre, OpenAPI-first |
| Core role | Universal foundation for Studio, Agora, Companion — not Studio-only |

### Remaining non-blocking questions

1. **Operation envelope workshop** — first worked examples: cross-module Save + drawing-approval pipeline?
2. **Agora sync conflicts** — Agora wins public vendor fields; Studio wins org trade status?
3. **Documents plugin v1** — org-wide vault only, or project-linked attachments too?
4. **Companion maps v1** — defer MapLibre to Agora web first?

---

## Current Structure Snapshot

```
erganis/                          # parent (Erganis Platform)
├── core/                         # Core: contracts, services, data, infra, packages, scripts
├── studio/                       # Studio: apps/studio, apps/client, modules/, shared/
├── agora/                        # Erganis Agora: web/, api/, shared/
├── companion/                    # mobile app
├── docs/
└── .apm/_WORKSPACE/
```

---

## Module & Feature Backlog

### Erganis Calendar

- [ ] **Events calendar** — Showings, openings, and similar events.

### Erganis Tools (candidate module — placement TBD)

- [ ] **Room size planner** — Square footage, furniture fit, occupancy; IBC code integration.

### Erganis Business

- [ ] **Metrics & dashboards**
- [ ] **Erganis Reports** — Custom reports; inventory/tracking docs; mobile-friendly.

### Erganis Documents

- [ ] **Document vault** — Resale certificates, trade docs; used by Studio Agora plugin.

### Studio Agora plugin (`studio/modules/agora`)

- [ ] **Org vendor list** — Local vendors + vendors from global Agora.
- [ ] **Trade account tracking** — Manual "Already done"; link to Documents; not on public Agora site.
- [ ] **Background vendor match** — Suggest sync from global Agora when matches found.

### Erganis Agora (`agora/`)

- [ ] **Public vendor search** — Standalone website; large global catalog.
- [ ] **Vendor profiles** — Onboarding links (resale cert email, web form).
- [ ] **MapLibre** — Vendor discovery map (web + mobile via MapLibre).

### Drawing approval (module / workflow TBD)

- [ ] **Drawing approval pipeline** — Multi-step sign-off workflow.

### Erganis Presentations

- [ ] **Presentation module** — Comments; client approval on items (cost/lead time).
- [ ] **Send proposals to clients**

### Erganis Planner (name to workshop)

- [ ] Kanban, Gantt, todos/reminders, vendor outreach, staff rotations, MEP milestones, responsibility + room layering.

### Core (cross-cutting)

- [ ] **Updater, installer, migrator**
- [ ] **Visual themes** — Core defaults + org overrides.

---

## Current TODOs

- [ ] Add fragment update/versioning support for managed fragment workflows.
- [ ] Workshop **Erganis Planner** final name.
- [ ] Decide **Erganis Tools** vs **Design** / **Build** for room size planner.
- [ ] Decide **Erganis Reports** as Business sub-module vs standalone.
- [ ] Decide **drawing approval** as standalone module vs workflow in Planner/Build.

---

## Notes

- ADR: [docs/adr/001-operation-envelope.md](../../docs/adr/001-operation-envelope.md)
- Module manifest: [core/contracts/schemas/module/](../../core/contracts/schemas/module/)
- Stack scaffold: [docs/STACK.md](../../docs/STACK.md)
