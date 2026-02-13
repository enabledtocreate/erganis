#!/usr/bin/env bash
# Archive old Erganis repos (replaced by erganis-platform + erganis-app-studio-portal).
# Requires: GitHub CLI (gh), logged in as enabledtocreate.
# Run from repo root. Does not touch enabledtocreate/erganis.

set -e
ORG="enabledtocreate"

old_repos=(
    erganis-stack
    erganis-docs
    erganis-database
    erganis-backend
    erganis-frontend
    erganis-api
    erganis-contracts
)

echo "Archiving old Erganis repos (parent erganis is not touched)"
echo ""

for name in "${old_repos[@]}"; do
    full="$ORG/$name"
    printf "Archiving %s ... " "$full"
    if gh repo archive "$full" 2>/dev/null; then
        echo "OK"
    else
        if gh repo view "$full" --json isArchived -q .isArchived 2>/dev/null | grep -q true; then
            echo "(already archived)"
        else
            echo "FAILED"
            exit 1
        fi
    fi
done

echo ""
echo "Done. To delete an archived repo: Repo -> Settings -> Danger zone -> Delete"
