# Archive old Erganis repos (replaced by erganis-platform + erganis-app-studio-portal).
# Requires: GitHub CLI (gh), logged in as enabledtocreate.
# Run from repo root. Does not touch enabledtocreate/erganis.

$ErrorActionPreference = "Stop"
$org = "enabledtocreate"

$oldRepos = @(
    "erganis-stack",
    "erganis-docs",
    "erganis-database",
    "erganis-backend",
    "erganis-frontend",
    "erganis-api",
    "erganis-contracts"
)

Write-Host "Archiving old Erganis repos (parent erganis is not touched)" -ForegroundColor Cyan
Write-Host ""

foreach ($name in $oldRepos) {
    $fullName = "$org/$name"
    Write-Host "Archiving $fullName ..." -NoNewline
    $result = gh repo archive $fullName 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host " OK" -ForegroundColor Green
    } else {
        if ($result -match "already archived") {
            Write-Host " (already archived)" -ForegroundColor Yellow
        } else {
            Write-Host " FAILED" -ForegroundColor Red
            Write-Host $result
        }
    }
}

Write-Host ""
Write-Host "Done. To delete an archived repo: Repo -> Settings -> Danger zone -> Delete" -ForegroundColor Cyan
