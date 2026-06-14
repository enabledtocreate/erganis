# Local development setup. Run from erganis (parent) repo root.
# PostgreSQL: Docker optional OR native install on Windows/Linux.

$ErrorActionPreference = "Stop"

Write-Host "Setting up Erganis Platform local development..." -ForegroundColor Cyan

if (Test-Path ".git") {
    if (Test-Path ".gitmodules") {
        if (-not (Test-Path "core/contracts/schemas")) {
            Write-Host "Initializing submodules..."
            git submodule update --init --recursive
        }
    }
}

$composeFile = "core/infrastructure/docker/docker-compose.yml"
if ((Get-Command docker -ErrorAction SilentlyContinue) -and (Test-Path $composeFile)) {
    Write-Host "Starting PostgreSQL via Docker (optional)..."
    docker compose -f $composeFile up -d postgres
    Start-Sleep -Seconds 3
} else {
    Write-Host "Docker not used — ensure PostgreSQL is running locally."
}

@("core/contracts", "core/services", "core/packages", "studio", "companion") | ForEach-Object {
    if (Test-Path "$_/package.json") {
        Write-Host "Installing dependencies in $_..."
        Push-Location $_
        npm install
        Pop-Location
    }
}

Write-Host ""
Write-Host "Setup complete." -ForegroundColor Green
Write-Host "  - Core Postgres: localhost:5432 (db erganis)"
Write-Host "  - Agora Postgres: agora/api/.env (db erganis_agora)"
Write-Host "  - Jobs: pg-boss (PostgreSQL); Redis not required for v1."
