#!/usr/bin/env bash
# Local development setup. Run from erganis (parent) repo root.
# PostgreSQL: use Docker (optional) OR native install on Windows/Linux.

set -e

echo "Setting up Erganis Platform local development..."

if [ -d ".git" ] && [ -f ".gitmodules" ] && [ ! -d "core/contracts/schemas" ]; then
  echo "Initializing submodules..."
  git submodule update --init --recursive
fi

COMPOSE_FILE="core/infrastructure/docker/docker-compose.yml"
if command -v docker >/dev/null 2>&1 && [ -f "$COMPOSE_FILE" ]; then
  echo "Starting PostgreSQL via Docker (optional)..."
  docker compose -f "$COMPOSE_FILE" up -d postgres
  sleep 3
else
  echo "Docker not used — ensure PostgreSQL is running locally (Core + Agora databases)."
fi

for dir in core/contracts core/services core/packages studio companion; do
  if [ -f "$dir/package.json" ]; then
    echo "Installing dependencies in $dir..."
    (cd "$dir" && npm install)
  fi
done

echo "Setup complete."
echo "  - Core Postgres: localhost:5432 (db erganis)"
echo "  - Agora Postgres: configure in agora/api/.env (db erganis_agora)"
echo "  - Copy .env.example files in core/, studio/, agora/ as needed."
echo "  - Jobs: pg-boss uses PostgreSQL (no Redis required for v1)."
