# Erganis App — ID Companion

**Mobile app** — Companion application for the Erganis platform (e.g. designer or client on the go).

## Structure

- **`app/`** — Main mobile application (screens, navigation, platform-specific entry points)
- **`shared/`** — Shared logic, API client, utilities, and types used by the app

Choose your stack (React Native, Flutter, or native iOS/Android) and add the corresponding project layout under `app/` (and optionally `ios/`, `android/` at repo root when needed). This repo consumes the **API layer** only (via URL or generated SDK).

## Dependencies

- **Erganis API** — Backend API (contracts/SDK or live OpenAPI URL)
- No direct reference to platform repo; use API base URL and auth.

## Environment variables

Copy `.env.example` to `.env` and set values.

| Variable | Required | Description |
|----------|----------|-------------|
| `API_BASE_URL` | Yes | API endpoint (e.g. https://api.erganis.example) |
| `API_TIMEOUT` | No | Request timeout ms (default 30000) |
| `AUTH_ENABLED` | No | Enable auth (default true) |
| `NODE_ENV` | No | development \| production |
| `LOG_LEVEL` | No | debug \| info \| warn \| error |

## GitHub

**Owner:** [enabledtocreate](https://github.com/enabledtocreate)  
**Repo:** `erganis-app-id-companion`
