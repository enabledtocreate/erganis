# One-command local development setup. Run from erganis repo root.

$ErrorActionPreference = "Stop"

Write-Host "Setting up Erganis local development environment..." -ForegroundColor Cyan

if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    Write-Host "Docker is required but not installed. Aborting." -ForegroundColor Red
    exit 1
}

# Optional: init submodules
if (Test-Path ".git") {
    if (Test-Path ".gitmodules") {
        if (-not (Test-Path "contracts/schemas")) {
            Write-Host "Initializing submodules..."
            git submodule update --init --recursive
        }
    }
}

# Start infrastructure
$composeFile = "infrastructure/docker/docker-compose.yml"
if (-not (Test-Path $composeFile)) {
    Write-Host "Not found: $composeFile. Run from erganis repo root." -ForegroundColor Red
    exit 1
}
Write-Host "Starting infrastructure services..."
docker compose -f $composeFile up -d

Write-Host "Waiting for services to start..."
Start-Sleep -Seconds 5

# Install dependencies
@("contracts", "studio-portal", "services", "packages") | ForEach-Object {
    if (Test-Path "$_/package.json") {
        Write-Host "Installing dependencies in $_..."
        Set-Location $_
        npm install
        Set-Location ..
    }
}

Write-Host ""
Write-Host "Setup complete." -ForegroundColor Green
Write-Host "  - Postgres: localhost:5432 (user erganis, password dev_password, db erganis)"
Write-Host "  - Redis: localhost:6379"
Write-Host "  - Copy .env.example to .env in each repo if needed."
Write-Host "  - Run 'npm run dev' in studio-portal/ or services/ to start development."
