#!/usr/bin/env bash
# Create Erganis sub-repos (parent erganis already exists). Run after: gh auth login

set -e
ORG="enabledtocreate"

repos=(
    "erganis-core:Core — contracts, data, infrastructure, services, packages, scripts"
    "erganis-studio:Studio and client apps, modules"
    "erganis-agora:Public vendor catalog — web, api, shared"
    "erganis-companion:Companion mobile app"
    "erganis-lyceum:Mnemosyne — historical design styles reference (web, optional api)"
)

echo "Creating sub-repos under GitHub account: $ORG"
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
echo "Done. Next: push local content (scripts/push-subrepos.sh) and add submodules (docs/GITHUB-SETUP.md)"
