#!/usr/bin/env bash
# Permanently delete old Erganis repos (replaced by erganis-platform + erganis-app-studio-portal).
# Requires: GitHub CLI (gh), logged in as enabledtocreate with delete_repo scope.
# To grant scope: gh auth refresh -s delete_repo
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

echo "This will PERMANENTLY DELETE these repos:"
for name in "${old_repos[@]}"; do echo "  $ORG/$name"; done
echo ""
read -p "Type 'yes' to delete: " confirm
if [ "$confirm" != "yes" ]; then
  echo "Aborted."
  exit 1
fi

echo ""
for name in "${old_repos[@]}"; do
  full="$ORG/$name"
  printf "Deleting %s ... " "$full"
  if gh repo delete "$full" --yes 2>/dev/null; then
    echo "OK"
  else
    echo "FAILED"
    exit 1
  fi
done
echo ""
echo "Done."
