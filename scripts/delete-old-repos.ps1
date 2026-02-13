# Permanently delete old Erganis repos (replaced by erganis-platform + erganis-app-studio-portal).
# Requires: GitHub CLI (gh), logged in as enabledtocreate with delete_repo scope.
# To grant scope: gh auth refresh -s delete_repo
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

Write-Host "This will PERMANENTLY DELETE these repos:" -ForegroundColor Red
foreach ($name in $oldRepos) { Write-Host "  $org/$name" }
Write-Host ""
$confirm = Read-Host "Type 'yes' to delete"
if ($confirm -ne "yes") {
    Write-Host "Aborted."
    exit 1
}

Write-Host ""
foreach ($name in $oldRepos) {
    $fullName = "$org/$name"
    Write-Host "Deleting $fullName ..." -NoNewline
    $result = gh repo delete $fullName --yes 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host " OK" -ForegroundColor Green
    } else {
        Write-Host " FAILED" -ForegroundColor Red
        Write-Host $result
    }
}
Write-Host ""
Write-Host "Done." -ForegroundColor Cyan
