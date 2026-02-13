# Erganis — CI/CD Workflows

GitHub Actions workflows for CI/CD across Linux and Windows runners.

## Workflows

| File | Purpose |
|------|--------|
| **ci.yml** | Runs on push/PR: checkout submodules, run tests in platform/contracts, platform/services, platform/packages, and studio-portal; then integration and E2E scripts. |
| **release.yml.example** | Template for release on version tags (e.g. publish SDKs). Copy to `release.yml` and add publish steps. |
| **deploy.yml.example** | Template for deploy (e.g. build, migrations, deploy). Copy to `deploy.yml` and add deploy steps. |

## Per-repo CI

When submodules are separate repos, each can have its own `.github/workflows/ci.yml` (e.g. Node or .NET). Use the same pattern: checkout, install, test, build. The parent `ci.yml` runs after submodules are checked out and runs tests in each folder that has a `package.json`.
