# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
# Install dependencies
make install-deps          # npm install + global mocha, nodemon

# Development
make run-app-dev-mode      # Run with nodemon auto-reload and debug enabled

# Testing
make tests                 # Unit tests: mocha --exit test/unit
make int-tests             # Integration tests: mocha --exit test/integration (requires SSL certs)
mocha --exit test/unit/some_unit_test.js     # Run a single test file

# Build
make dist                  # Generate SSL certs + build info
make image                 # Build Docker image
make run                   # Run Docker container (ports 8080/8443)
make all                   # Full build: tests + image + Helm chart
```

Integration tests require SSL certificates — run `./generate-ssl-certs.sh` if they're missing.

## Architecture

**Entry point**: `app.js` — creates an Express app, mounts middleware and routes, starts HTTP (8080) and HTTPS (8443) servers.

**Routes** (`routes/`): Each file exports an Express router for one endpoint group:
- `index.js` → `GET /`
- `api.js` → `GET|POST /api/*` (includes test endpoints for 3xx/4xx/5xx/runtimeError)
- `build_info.js` → `GET /build-info` (returns git branch, commit, build time from `build-info-data.js`)
- `live_probe.js` / `ready_probe.js` → `GET /probe/live` and `GET /probe/ready` (Kubernetes health probes)

**Middleware** (`middleware/statsd/`): Two pieces of StatsD instrumentation are applied globally:
- `timing.js` — records request duration per endpoint
- `status_code.js` — counts responses by status class (2xx/3xx/4xx/5xx) per endpoint

**Build metadata**: `build-info-data.js` is a generated file (via `generate-build-info.sh`) that contains `branch`, `version` (commit hash), and `build_time`. It is committed when building locally but regenerated in CI.

**Test framework**: Mocha + Chai + chai-http. Unit tests in `test/unit/`, integration tests in `test/integration/`.

**Deployment**: `deployment/k8s/helm/` contains a Helm chart for Kubernetes. The app exposes liveness/readiness probe endpoints for K8s health checks.

**CI/CD**: `.github/workflows/build.yml` — on push to `main` or PRs, it generates SSL certs and build info, then builds and pushes a Docker image to `jecklgamis/expressjs-app-example` (push only on `main`, not PRs).
