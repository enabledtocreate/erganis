# Erganis Services

**Application tier** — backend services, business logic, and API gateway.

## Structure

- `api-gateway/` — API gateway/routing layer
- `business-logic/` — Core business logic services
- `background-jobs/` — Background workers, scheduled tasks
- `shared/` — Shared service code, middleware, utilities

## Services

Services implement business logic and expose APIs consumed by **apps**. They use the **data layer** (`../data/`) for persistence and may use **packages** for shared utilities.

## Technology stacks

Services can be implemented in different technologies (e.g. .NET, Java, Node.js). Each service or subfolder can choose its stack, or you can organize by stack (e.g. `services/dotnet/`, `services/java/`).

## GitHub

**Owner:** [enabledtocreate](https://github.com/enabledtocreate)  
**Repo:** `erganis-services`

## Environment variables

Copy `.env.example` to `.env` and set values.

| Variable | Required | Description |
|----------|----------|-------------|
| `DATABASE_URL` | Yes | PostgreSQL connection string |
| `REDIS_URL` | No | Redis URL (default redis://localhost:6379) |
| `API_PORT` | No | API port (default 5000) |
| `API_HOST` | No | Bind host (default 0.0.0.0) |
| `LOG_LEVEL` | No | info \| debug \| warn \| error |
| `NODE_ENV` | No | development \| production |

## Related repos

- **erganis-contracts** — API contracts and schemas
- **platform/data** — Data layer (DAL, migrations, SQL)
- **erganis-packages** — Shared libraries and tools
