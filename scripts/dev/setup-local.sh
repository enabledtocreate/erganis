#!/usr/bin/env bash
# One-command local development setup. Run from erganis (parent) repo root.

set -e

echo "Setting up Erganis local development environment..."

command -v docker >/dev/null 2>&1 || {
  echo "Docker is required but not installed. Aborting." >&2
  exit 1
}

# Optional: init submodules if running from full clone
if [ -d ".git" ] && [ -f ".gitmodules" ] && [ ! -d "platform/contracts/schemas" ]; then
  echo "Initializing submodules..."
  git submodule update --init --recursive
fi

# Start infrastructure (Postgres, Redis) from platform
echo "Starting infrastructure services..."
COMPOSE_FILE="platform/infrastructure/docker/docker-compose.yml"
if [ ! -f "$COMPOSE_FILE" ]; then
  echo "Not found: $COMPOSE_FILE. Run from erganis repo root." >&2
  exit 1
fi
docker compose -f "$COMPOSE_FILE" up -d

echo "Waiting for services to start..."
sleep 5

# Install dependencies in platform and app repos
for dir in platform/contracts platform/services platform/packages studio-portal; do
  if [ -f "$dir/package.json" ]; then
    echo "Installing dependencies in $dir..."
    (cd "$dir" && npm install)
  fi
done

echo "Setup complete."
echo "  - Postgres: localhost:5432 (user erganis, password dev_password, db erganis)"
echo "  - Redis: localhost:6379"
echo "  - Copy .env.example to .env in platform/ or studio-portal/ if needed."
echo "  - Run 'npm run dev' in studio-portal/ or platform/services/ to start development."
