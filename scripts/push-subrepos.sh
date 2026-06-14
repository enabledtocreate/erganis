#!/usr/bin/env bash
# Create erganis sub-repos on GitHub (if missing), then push core/, studio/, agora/, companion/.
# Run from erganis repo root. Requires: gh, git.

set -e
ORG="enabledtocreate"
ROOT="$(cd "$(dirname "$0")/.." && pwd)"

for d in core studio agora companion; do
  if [ ! -d "$ROOT/$d" ]; then
    echo "Missing $ROOT/$d — run from erganis repo root."
    exit 1
  fi
done

declare -A DESCS=(
  [erganis-core]="Core — contracts, data, infrastructure, services, packages, scripts"
  [erganis-studio]="Studio and client apps, modules"
  [erganis-agora]="Public vendor catalog — web, api, shared"
  [erganis-companion]="Companion mobile app"
)

for name in erganis-core erganis-studio erganis-agora erganis-companion; do
  full="$ORG/$name"
  if ! gh repo view "$full" &>/dev/null; then
    echo "Creating $full ..."
    gh repo create "$full" --public --description "${DESCS[$name]}"
  fi
done

push_subrepo() {
  local dir="$1"
  local repo_name="$2"
  local commit_msg="$3"
  local path="$ROOT/$dir"
  if [ -d "$path/.git" ]; then
    (cd "$path" && git remote add origin "https://github.com/$ORG/$repo_name.git" 2>/dev/null; true)
    (cd "$path" && git push -u origin main 2>/dev/null || git push -u origin master 2>/dev/null)
    return
  fi
  (cd "$path" && git init && git add . && git commit -m "$commit_msg" && git branch -M main && git remote add origin "https://github.com/$ORG/$repo_name.git" && git push -u origin main)
}

echo ""
push_subrepo "core" "erganis-core" "Initial Core (contracts, data, services, packages, scripts)"
push_subrepo "studio" "erganis-studio" "Initial Studio (apps/studio, apps/client, modules)"
push_subrepo "agora" "erganis-agora" "Initial Erganis Agora (web, api, shared)"
push_subrepo "companion" "erganis-companion" "Initial Companion mobile app"

echo ""
echo "Done. See docs/GITHUB-SETUP.md for submodules."
