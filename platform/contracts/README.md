# Erganis Contracts

**Schemas and auto-generated SDKs** — the source of truth for API contracts, message schemas, and generated client libraries.

## Purpose

- **Core API** — Single OpenAPI spec (`schemas/core/openapi.yaml`) for the full internal API.
- **Public API** — Generated subset (by `x-audience: public`) in `schemas/public/v1/`, `v2/`, etc., for third-party consumers.
- **SDKs** — Auto-generated from schemas for different languages/platforms (future).
- **Usage** — Services and infrastructure use contracts via relative paths; app repos (e.g. studio-portal) consume the API (live URL or generated client).

## Structure

- `schemas/core/` — Core API spec (single source of truth).
- `schemas/public/v1/`, `v2/`, … — Generated public API subsets; do not edit by hand.
- `sdk/` — Auto-generated SDKs (e.g. `sdk/dotnet/`, `sdk/typescript/`).
- `scripts/generate-public-api.js` — Generates public subset from core.

See [schemas/README.md](schemas/README.md) for tagging, generation, and support policy.

## Generating the public API

```bash
npm install
npm run generate-public
# Or: node scripts/generate-public-api.js v2
```

## Environment variables

See `.env.example`. Optional: `SDK_OUTPUT_DIR`, `SDK_LANGUAGES`, `OPENAPI_VERSION`.

## GitHub

Contracts live inside **erganis-platform**. **Owner:** [enabledtocreate](https://github.com/enabledtocreate)  
**Repo:** `erganis-platform` (this folder is `platform/contracts/`)
