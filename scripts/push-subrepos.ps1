# Create erganis-platform, erganis-app-studio-portal, erganis-app-id-companion on GitHub (if missing),
# then push the local platform/, studio-portal/, and id-companion/ folders to them.
# Run from the erganis repo root. Requires: GitHub CLI (gh), git.

$ErrorActionPreference = "Stop"
$org = "enabledtocreate"
$root = Split-Path -Parent $PSScriptRoot
if (-not (Test-Path "$root\platform") -or -not (Test-Path "$root\studio-portal") -or -not (Test-Path "$root\id-companion")) {
    Write-Host "Run this from the erganis repo root (parent of platform/, studio-portal/, id-companion/)." -ForegroundColor Red
    exit 1
}

# Create the repos on GitHub if they don't exist (gh repo create skips if exists)
Write-Host "Ensuring erganis-platform, erganis-app-studio-portal, erganis-app-id-companion exist on GitHub ..." -ForegroundColor Cyan
$repos = @(
    @{ name = "erganis-platform"; desc = "Contracts, data, infrastructure, services, packages, scripts (one repo)" },
    @{ name = "erganis-app-studio-portal"; desc = "Studio and client portal apps (one repo, two folders)" },
    @{ name = "erganis-app-id-companion"; desc = "ID Companion mobile app" }
)
foreach ($r in $repos) {
    $full = "$org/$($r.name)"
    Write-Host "  $full ..." -NoNewline
    try { $null = & gh repo create $full --public --description $r.desc 2>&1; if ($LASTEXITCODE -eq 0) { Write-Host " created" -ForegroundColor Green } else { Write-Host " (exists)" -ForegroundColor Yellow } } catch { Write-Host " (exists)" -ForegroundColor Yellow }
}

function Push-Subrepo {
    param([string]$dir, [string]$repoName, [string]$commitMsg)
    $path = Join-Path $root $dir
    $gitDir = Join-Path $path ".git"
    if (Test-Path $gitDir) {
        Push-Location $path
        try {
            git remote get-url origin 2>$null
            if ($LASTEXITCODE -ne 0) { git remote add origin "https://github.com/$org/$repoName.git" }
            git push -u origin main 2>$null
            if ($LASTEXITCODE -ne 0) { git push -u origin master 2>$null }
        } finally { Pop-Location }
        return
    }
    Push-Location $path
    try {
        git init
        git add .
        git commit -m $commitMsg
        git branch -M main
        git remote add origin "https://github.com/$org/$repoName.git"
        git push -u origin main
    } finally { Pop-Location }
}

Write-Host ""
Write-Host "Pushing platform/ to $org/erganis-platform ..." -ForegroundColor Cyan
Push-Subrepo -dir "platform" -repoName "erganis-platform" -commitMsg "Initial platform (contracts, infrastructure, services, packages, scripts)"

Write-Host ""
Write-Host "Pushing studio-portal/ to $org/erganis-app-studio-portal ..." -ForegroundColor Cyan
Push-Subrepo -dir "studio-portal" -repoName "erganis-app-studio-portal" -commitMsg "Initial studio and client portal"

Write-Host ""
Write-Host "Pushing id-companion/ to $org/erganis-app-id-companion ..." -ForegroundColor Cyan
Push-Subrepo -dir "id-companion" -repoName "erganis-app-id-companion" -commitMsg "Initial ID Companion mobile app"

Write-Host ""
Write-Host "Done. You should now see erganis-platform, erganis-app-studio-portal, and erganis-app-id-companion on GitHub." -ForegroundColor Green
Write-Host "To switch the parent to submodules: see docs/GITHUB-SETUP.md section 5." -ForegroundColor Cyan
