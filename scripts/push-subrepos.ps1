# Push core/, studio/, agora/, companion/, lyceum/ to GitHub sub-repos.
# Run from erganis repo root. Requires: gh, git.

$ErrorActionPreference = "Stop"
$org = "enabledtocreate"
$root = Split-Path -Parent $PSScriptRoot

foreach ($d in @("core", "studio", "notes", "agora", "companion", "lyceum")) {
    if (-not (Test-Path "$root\$d")) {
        Write-Host "Missing $root\$d - run from erganis repo root." -ForegroundColor Red
        exit 1
    }
}

$repos = @(
    @{ name = "erganis-core"; desc = "Core: contracts, data, infrastructure, services, packages, scripts" },
    @{ name = "erganis-studio"; desc = "Studio and client apps, modules" },
    @{ name = "erganis-notes"; desc = "Shared Notes module: constructable documents, annotations, dialogue, bibliography" },
    @{ name = "erganis-agora"; desc = "Public vendor catalog: web, api, shared" },
    @{ name = "erganis-companion"; desc = "Companion mobile app" },
    @{ name = "erganis-lyceum"; desc = "Mnemosyne — historical design styles reference (web, optional api)" }
)

foreach ($r in $repos) {
    $full = "$org/$($r.name)"
    Write-Host "Ensuring $full ..." -NoNewline
    try {
        $null = gh repo create $full --public --description $r.desc 2>&1
        if ($LASTEXITCODE -eq 0) { Write-Host " created" -ForegroundColor Green } else { Write-Host " (exists)" -ForegroundColor Yellow }
    } catch { Write-Host " (exists)" -ForegroundColor Yellow }
}

function Push-Subrepo {
    param([string]$dir, [string]$repoName, [string]$commitMsg)
    $path = Join-Path $root $dir
    if (Test-Path (Join-Path $path ".git")) {
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

Push-Subrepo -dir "core" -repoName "erganis-core" -commitMsg "Initial Core"
Push-Subrepo -dir "studio" -repoName "erganis-studio" -commitMsg "Initial Studio"
Push-Subrepo -dir "notes" -repoName "erganis-notes" -commitMsg "Initial Erganis Notes (docs scaffold)"
Push-Subrepo -dir "agora" -repoName "erganis-agora" -commitMsg "Initial Erganis Agora"
Push-Subrepo -dir "companion" -repoName "erganis-companion" -commitMsg "Initial Companion"
Push-Subrepo -dir "lyceum" -repoName "erganis-lyceum" -commitMsg "Initial Erganis Lyceum (Mnemosyne)"

Write-Host "Done. See docs/GITHUB-SETUP.md" -ForegroundColor Green
