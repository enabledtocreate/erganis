# Erganis Platform

Single repo for the **tightly coupled backend**: contracts, infrastructure, services, packages, and scripts. Everything that cannot stand alone lives here.

## Structure

| Folder | Purpose |
|--------|---------|
| **contracts/** | Schemas and auto-generated SDKs; core + public API |
| **infrastructure/** | DAL, migrations, SQL, Docker, deployment |
| **services/** | API gateway, business logic, background jobs |
| **packages/** | Shared UI libraries, loggers, utilities |
| **scripts/** | Setup, deploy, dev, maintenance |

Use **relative paths** between these folders (no submodules inside this repo).

## Apps

Apps live in **separate repos** (e.g. `erganis-app-studio-portal`). They consume only the **API** (live URL or generated SDK), not this repo directly.

## GitHub

**Owner:** [enabledtocreate](https://github.com/enabledtocreate)  
**Repo:** `erganis-platform`
