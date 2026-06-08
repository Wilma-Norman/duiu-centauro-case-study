#Requires -Version 5.1
<#
.SYNOPSIS
    Run Postgres locally with Docker Desktop (Windows / PowerShell)

.NOTES
    No docker-compose. No TLS. No Azure. No Key Vault.

    Connect from other local containers using:
        DB_HOST=postgres
        DB_PORT=5432
        DB_NAME=campaign_report_db
        DB_USER=wilmanorman
        DB_SSLMODE=disable
#>

# Do NOT use Stop here - native docker commands write harmless warnings to stderr
# which PowerShell 5.1 wraps as NativeCommandError and terminates the script.
$ErrorActionPreference = "Continue"

$ServiceName  = "postgres"
$ImageName    = "postgres:16.3"
$NetworkName  = "duiu-local"
$DataVolume   = "duiu_postgres_data"

$ScriptDir    = Split-Path -Parent $MyInvocation.MyCommand.Definition
$RepoRoot     = (Resolve-Path (Join-Path $ScriptDir "..\..")).Path
$PgDir        = Join-Path $RepoRoot "postgres"
$EnvFile      = Join-Path $PgDir "configs\.env.local"
$PasswordFile = Join-Path $PgDir "configs\postgres_password.txt"

Write-Host "[>] Running local Postgres"
Write-Host "[>] Repo root:    $RepoRoot"
Write-Host "[>] Postgres dir: $PgDir"
Write-Host "[>] Network:      $NetworkName"
Write-Host "[>] Container:    $ServiceName"

# ------------------------------------------------------------
# Guardrails
# ------------------------------------------------------------

if (-not (Test-Path $EnvFile)) {
    Write-Host "[x] Missing env file: $EnvFile"
    exit 1
}

if (-not (Test-Path $PasswordFile)) {
    Write-Host "[x] Missing password file: $PasswordFile"
    exit 1
}

if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    Write-Host "[x] Docker CLI not found. Install/start Docker Desktop first."
    exit 1
}

# Use Invoke-Expression so stderr goes to the console without becoming error records
$null = docker ps 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Host "[x] Docker is not running or not reachable. Start Docker Desktop first."
    exit 1
}

# ------------------------------------------------------------
# Ensure deterministic local Docker resources
# ------------------------------------------------------------

$null = docker network inspect $NetworkName 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Host "[>] Creating network $NetworkName"
    $null = docker network create $NetworkName
}

$null = docker volume create $DataVolume

Write-Host "[>] Pulling image $ImageName"
docker pull $ImageName
if ($LASTEXITCODE -ne 0) { Write-Host "[x] Failed to pull image"; exit 1 }

Write-Host "[>] Removing any existing container named $ServiceName"
$null = docker rm -f $ServiceName 2>$null

Write-Host "[>] Starting Postgres container"

docker run -d `
    --name $ServiceName `
    --restart unless-stopped `
    --network $NetworkName `
    -p "127.0.0.1:5432:5432" `
    --env-file $EnvFile `
    -v "${DataVolume}:/var/lib/postgresql/data" `
    -v "${PasswordFile}:/run/secrets/postgres_password:ro" `
    $ImageName

if ($LASTEXITCODE -ne 0) {
    Write-Host "[x] Failed to start Postgres container"
    exit 1
}

Write-Host "[>] Postgres container started"
Write-Host "[>] Host access:      127.0.0.1:5432"
Write-Host "[>] Container access: postgres:5432"
Write-Host "[>] DB name:          campaign_report_db"
Write-Host "[>] DB user:          wilmanorman"

# ------------------------------------------------------------
# Wait for healthy
# ------------------------------------------------------------

Write-Host "[>] Waiting for Postgres to be ready..."
$retries = 20
$ready   = $false

for ($i = 0; $i -lt $retries; $i++) {
    $null = docker exec $ServiceName pg_isready -U wilmanorman -d campaign_report_db 2>$null
    if ($LASTEXITCODE -eq 0) {
        $ready = $true
        break
    }
    Start-Sleep -Seconds 1
}

if (-not $ready) {
    Write-Host "[x] Postgres did not become ready in time"
    docker logs $ServiceName
    exit 1
}

Write-Host "[ok] Postgres is ready and accepting connections"
Write-Host "[>] Tailing logs for $ServiceName (Ctrl+C to stop)"

docker logs -f --tail 200 $ServiceName
