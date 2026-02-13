#!/usr/bin/env bash
# Create erganis-platform and erganis-app-studio-portal on GitHub (if missing),
# then push the local platform/ and studio-portal/ folders to them as separate repos.
# Run from the erganis repo root. Requires: GitHub CLI (gh), git.

set -e
ORG="enabledtocreate"
ROOT="$(cd "$(dirname "$0")/.." && pwd)"

if [ ! -d "$ROOT/platform" ] || [ ! -d "$ROOT/studio-portal" ]; then
  echo "Run this from the erganis repo root (parent of platform/ and studio-portal/)."
  exit 1
fi

# Ensure the two repos exist on GitHub
for name in erganis-platform erganis-app-studio-portal; do
  full="$ORG/$name"
  if ! gh repo view "$full" &>/dev/null; then
    echo "Creating $full ..."
    if [ "$name" = "erganis-platform" ]; then
      desc="Contracts, infrastructure, services, packages, scripts (one repo)"
    else
      desc="Studio and client portal apps (one repo, two folders)"
    fi
    gh repo create "$full" --public --description "$desc"
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
echo "Pushing platform/ to $ORG/erganis-platform ..."
push_subrepo "platform" "erganis-platform" "Initial platform (contracts, infrastructure, services, packages, scripts)"

echo ""
echo "Pushing studio-portal/ to $ORG/erganis-app-studio-portal ..."
push_subrepo "studio-portal" "erganis-app-studio-portal" "Initial studio and client portal"

echo ""
echo "Done. You should now see erganis-platform and erganis-app-studio-portal on GitHub."
echo "To switch the parent to submodules: see docs/GITHUB-SETUP.md section 4."
