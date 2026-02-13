# Create Erganis GitHub repos (parent + two sub-repos). Run after: gh auth login
# Requires: GitHub CLI (gh) - https://cli.github.com/

$ErrorActionPreference = "Stop"
$org = "enabledtocreate"

$repos = @(
    @{ Name = "erganis"; Description = "Erganis - open-source platform (parent repo)" },
    @{ Name = "erganis-platform"; Description = "Contracts, infrastructure, services, packages, scripts (one repo)" },
    @{ Name = "erganis-app-studio-portal"; Description = "Studio and client portal apps (one repo, two folders)" }
)

Write-Host "Creating repos under GitHub account: $org" -ForegroundColor Cyan
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
