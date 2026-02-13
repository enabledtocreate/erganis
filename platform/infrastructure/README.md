# Erganis Infrastructure

**Data & environment tier** — persistence, migrations, and infrastructure-as-code.

## Structure

- `dal/` — Database Abstraction Layer (DAL) — data access code
- `migrations/` — Database migration scripts (versioned)
- `sql/` — SQL logic, stored procedures, views
- `docker/` — Dockerfiles, docker-compose, container configs
- `deployment/` — Infrastructure-as-code (Terraform, ARM, CloudFormation, etc.)

## Purpose

- **Persistence** — Database schemas, migrations, and data access layer
- **Environment** — Docker, deployment configs, infrastructure provisioning
- **Data logic** — SQL scripts, stored procedures, database-specific code

## Usage

- **Services** use the DAL for data access
- Migrations are run as part of deployment pipelines
- Docker configs define runtime environments

## GitHub

**Owner:** [enabledtocreate](https://github.com/enabledtocreate)  
**Repo:** `erganis-infrastructure`

## Environment variables

Copy `.env.example` to `.env` for migration and deployment scripts.

| Variable | Required | Description |
|----------|----------|-------------|
| `POSTGRES_HOST` | Yes | Database host |
| `POSTGRES_PORT` | No | Port (default 5432) |
| `POSTGRES_DB` | Yes | Database name |
| `POSTGRES_USER` | Yes | Database user |
| `POSTGRES_PASSWORD` | Yes | Database password |
| `MIGRATION_DIR` | No | Path to migrations (default ./migrations) |

## Related repos

- **erganis-services** — Services that consume the DAL
- **erganis-contracts** — Schema definitions used for migrations
