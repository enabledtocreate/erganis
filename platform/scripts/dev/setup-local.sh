#!/usr/bin/env bash
# One-command local development setup. Run from platform repo root (erganis-platform).

set -e

echo "Setting up Erganis local development environment..."

command -v docker >/dev/null 2>&1 || {
  echo "Docker is required but not installed. Aborting." >&2
  exit 1
}

# Start infrastructure (Postgres, Redis). Run from platform repo root.
echo "Starting infrastructure services..."
COMPOSE_FILE="infrastructure/docker/docker-compose.yml"
if [ ! -f "$COMPOSE_FILE" ]; then
  echo "Not found: $COMPOSE_FILE. Run from platform repo root." >&2
  exit 1
fi
docker compose -f "$COMPOSE_FILE" up -d

echo "Waiting for services to start..."
sleep 5

# Optional: run migrations when they exist
# if [ -d "data/migrations" ]; then
#   echo "Running database migrations..."
#   (cd data && npm run migrate 2>/dev/null) || true
# fi

# Install dependencies in platform folders that have package.json
for dir in contracts data services packages; do
  if [ -f "$dir/package.json" ]; then
    echo "Installing dependencies in $dir..."
    (cd "$dir" && npm install)
  fi
done

echo "Setup complete (platform only)."
echo "  - Postgres: localhost:5432 (user erganis, password dev_password, db erganis)"
echo "  - Redis: localhost:6379"
echo "  - Copy .env.example to .env in contracts/, services/, etc. if needed."
echo "  - Run 'npm run dev' in services/ to start development."
