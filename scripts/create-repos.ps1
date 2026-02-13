# Create the two new Erganis sub-repos (erganis already exists). Run after: gh auth login
# Requires: GitHub CLI (gh) - https://cli.github.com/

$ErrorActionPreference = "Stop"
$org = "enabledtocreate"

# Only the two new sub-repos; parent erganis already exists
$repos = @(
    @{ Name = "erganis-platform"; Description = "Contracts, infrastructure, services, packages, scripts (one repo)" },
    @{ Name = "erganis-app-studio-portal"; Description = "Studio and client portal apps (one repo, two folders)" }
)

Write-Host "Creating two sub-repos under GitHub account: $org (parent erganis already exists)" -ForegroundColor Cyan
Write-Host ""

foreach ($r in $repos) {
    $fullName = "$org/$($r.Name)"
    Write-Host "Creating $fullName ..." -NoNewline
    $result = gh repo create $fullName --public --description $r.Description 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host " OK" -ForegroundColor Green
    } else {
        if ($result -match "already exists") {
            Write-Host " (already exists)" -ForegroundColor Yellow
        } else {
            Write-Host " FAILED" -ForegroundColor Red
            Write-Host $result
        }
    }
}

Write-Host ""
Write-Host 'Done. Next: push your local content and add submodules (see docs/GITHUB-SETUP.md)' -ForegroundColor Cyan
