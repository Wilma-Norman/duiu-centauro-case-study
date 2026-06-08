#!/usr/bin/env bash
set -euo pipefail

# ------------------------------------------------------------
# Run Postgres locally with Docker Desktop
#
# No docker-compose.
# No TLS.
# No Azure.
# No Key Vault.
#
# The container is attached to the shared local Docker network:
#   duiu-local
#
# Other local app containers should connect using:
#   DB_HOST=postgres
#   DB_PORT=5432
#   DB_NAME=campaign_report_db
#   DB_USER=wilmanorman
#   DB_PASSWORD=Cortina123!
#   DB_SSLMODE=disable
# ------------------------------------------------------------

SERVICE_NAME="postgres"
IMAGE_NAME="postgres:16.3"
NETWORK_NAME="duiu-local"
DATA_VOLUME="duiu_postgres_data"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/../.." && pwd)"
PG_DIR="${REPO_ROOT}/postgres"

ENV_FILE="${PG_DIR}/configs/.env.local"
PASSWORD_FILE="${PG_DIR}/configs/postgres_password.txt"

PORTS=(
  "-p" "127.0.0.1:5432:5432"
)

VOLUMES=(
  "-v" "${DATA_VOLUME}:/var/lib/postgresql/data"
  "-v" "${PASSWORD_FILE}:/run/secrets/postgres_password:ro"
)

echo "▶ Running local Postgres"
echo "▶ Repo root: ${REPO_ROOT}"
echo "▶ Postgres dir: ${PG_DIR}"
echo "▶ Network: ${NETWORK_NAME}"
echo "▶ Container name: ${SERVICE_NAME}"

# ------------------------------------------------------------
# Guardrails
# ------------------------------------------------------------

if [[ ! -f "${ENV_FILE}" ]]; then
  echo "✖ Missing env file: ${ENV_FILE}" >&2
  exit 1
fi

if [[ ! -f "${PASSWORD_FILE}" ]]; then
  echo "✖ Missing password file: ${PASSWORD_FILE}" >&2
  exit 1
fi

if ! command -v docker >/dev/null 2>&1; then
  echo "✖ Docker CLI not found. Install/start Docker Desktop first." >&2
  exit 1
fi

if ! docker info >/dev/null 2>&1; then
  echo "✖ Docker is not running or not reachable. Start Docker Desktop first." >&2
  exit 1
fi

# ------------------------------------------------------------
# Ensure deterministic local Docker resources
# ------------------------------------------------------------

docker network inspect "${NETWORK_NAME}" >/dev/null 2>&1 || docker network create "${NETWORK_NAME}" >/dev/null
docker volume create "${DATA_VOLUME}" >/dev/null

echo "▶ Pulling image ${IMAGE_NAME}"
docker pull "${IMAGE_NAME}" >/dev/null

echo "▶ Removing any existing container named ${SERVICE_NAME}"
docker rm -f "${SERVICE_NAME}" 2>/dev/null || true

echo "▶ Starting Postgres container"

docker run -d \
  --name "${SERVICE_NAME}" \
  --restart unless-stopped \
  --network "${NETWORK_NAME}" \
  "${PORTS[@]}" \
  --env-file "${ENV_FILE}" \
  "${VOLUMES[@]}" \
  "${IMAGE_NAME}"

echo "▶ Postgres started"
echo "▶ Host access: 127.0.0.1:5432"
echo "▶ Container access from app containers: postgres:5432"
echo "▶ DB name: campaign_report_db"
echo "▶ DB user: wilmanorman"

# ------------------------------------------------------------
# Wait for healthy
# ------------------------------------------------------------

echo "▶ Waiting for Postgres to be ready..."
RETRIES=15
until docker exec "${SERVICE_NAME}" pg_isready -U wilmanorman -d campaign_report_db >/dev/null 2>&1; do
  RETRIES=$((RETRIES - 1))
  if [[ "${RETRIES}" -le 0 ]]; then
    echo "✖ Postgres did not become ready in time" >&2
    docker logs "${SERVICE_NAME}" >&2
    exit 1
  fi
  sleep 1
done

echo "✔ Postgres is ready"
echo "▶ Tailing logs for ${SERVICE_NAME} (Ctrl+C detaches from logs only)"

docker logs -f --tail=200 "${SERVICE_NAME}"
