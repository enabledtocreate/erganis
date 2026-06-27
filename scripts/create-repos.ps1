# Create Erganis sub-repos. Run after: gh auth login

$ErrorActionPreference = "Stop"
$org = "enabledtocreate"

$repos = @(
    @{ Name = "erganis-core"; Description = "Core: contracts, data, infrastructure, services, packages, scripts" },
    @{ Name = "erganis-studio"; Description = "Studio and client apps, modules" },
    @{ Name = "erganis-agora"; Description = "Public vendor catalog: web, api, shared" },
    @{ Name = "erganis-companion"; Description = "Companion mobile app" },
    @{ Name = "erganis-lyceum"; Description = "Mnemosyne — historical design styles reference (web, optional api)" }
)

Write-Host "Creating sub-repos under GitHub account: $org" -ForegroundColor Cyan

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
Write-Host "Done. Next: scripts/push-subrepos.ps1 and docs/GITHUB-SETUP.md" -ForegroundColor Cyan
