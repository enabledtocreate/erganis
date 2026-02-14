#!/usr/bin/env bash
# Create the two new Erganis sub-repos (erganis already exists). Run after: gh auth login
# Requires: GitHub CLI (gh) - https://cli.github.com/

set -e
ORG="enabledtocreate"

# Sub-repos; parent erganis already exists
repos=(
    "erganis-platform:Contracts, data, infrastructure, services, packages, scripts (one repo)"
    "erganis-app-studio-portal:Studio and client portal apps (one repo, two folders)"
    "erganis-app-id-companion:ID Companion mobile app"
)

echo "Creating sub-repos under GitHub account: $ORG (parent erganis already exists)"
echo ""

for entry in "${repos[@]}"; do
    name="${entry%%:*}"
    desc="${entry#*:}"
    full="$ORG/$name"
    printf "Creating %s ... " "$full"
    if gh repo create "$full" --public --description "$desc" 2>/dev/null; then
        echo "OK"
    else
        if gh repo view "$full" &>/dev/null; then
            echo "(already exists)"
        else
            echo "FAILED"
            exit 1
        fi
    fi
done

echo ""
echo "Done. Next: push your local content and add submodules (see docs/GITHUB-SETUP.md)"
