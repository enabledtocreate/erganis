# Erganis App — Studio & Client Portal

**Presentation tier** — Designer studio and client-facing portal in one repo.

## Structure

- **`studio/`** — Designer studio application (web/desktop)
- **`client-portal/`** — Client-facing portal
- **`shared/`** — Shared UI components, API clients, and utilities used by both apps

Each app is a separate folder with its own build/deploy setup. Both consume the **API layer** (via contracts SDKs or live OpenAPI URL) and may use **erganis-packages** for shared libraries.

## Dependencies

- **erganis-contracts** — API contracts and SDKs (or live API spec URL)
- **erganis-services** — Backend API
- **erganis-packages** — Shared UI libraries (optional)

## Environment variables

Copy `.env.example` to `.env` and set values.

| Variable | Required | Description |
|----------|----------|-------------|
| `API_BASE_URL` | Yes | API endpoint (e.g. http://localhost:5000) |
| `API_TIMEOUT` | No | Request timeout ms (default 30000) |
| `AUTH_ENABLED` | No | Enable auth (default true) |
| `NODE_ENV` | No | development \| production |
| `LOG_LEVEL` | No | debug \| info \| warn \| error |

## GitHub

**Owner:** [enabledtocreate](https://github.com/enabledtocreate)  
**Repo:** `erganis-app-studio-portal`
