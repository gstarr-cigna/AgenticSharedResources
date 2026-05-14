# MDLive Dev Environment — Reference

## All Make Targets

Run `make help` for the live list. Common targets follow the `<service>` or `<alias>` pattern:

| Target                      | Description                              |
|-----------------------------|------------------------------------------|
| `make <service>`            | Start service + dependencies             |
| `make <service>-stop`       | Stop service container                   |
| `make <service>-restart`    | Stop then start service                  |
| `make <service>-build`      | Build Docker image                       |
| `make <service>-rebuild`    | Destroy + rebuild image                  |
| `make <service>-bash`       | Open bash shell in container             |
| `make <service>-attach`     | Attach to container (Byebug)             |
| `make <service>-console`    | Rails console                            |
| `make <service>-logs`       | Tail container logs                      |
| `make <service>-bundle-install` | Run bundle install                   |
| `make clone-<service>`      | Clone service repo                       |
| `make clone-all`            | Clone all service repos                  |
| `make pull-staging`         | Pull all repos to staging branch         |
| `make stash-all`            | Stash all local changes across repos     |
| `make db-console`           | MySQL CLI in db container                |
| `make stern-db-setup`       | Stern DB setup (dev + test)              |
| `make stern-db-migrate`     | Stern DB migrations                      |
| `make stern-elasticsearch-index` | Rebuild Elasticsearch index         |
| `make affiliation-manager-init` | AFM bundle install + db setup        |
| `make shell-config`         | Print shell alias config                 |
| `make otel`                 | Start OpenTelemetry stack                |

Service aliases: `stern`, `api` (rest-api), `prp` (provider-portal), `pap` (patient-portal), `csa`, `afm` (affiliation-manager), `legacy`.

## Raw Docker Compose Commands

```bash
# Start with dependency health-check wait
docker compose up --wait <service>

# Stop
docker compose stop <service>

# Attach for Byebug
docker compose attach <service>
# Detach: Ctrl-p Ctrl-q
```

## Building & Pushing Images to Quay

### Prerequisites

1. **Quay credentials** — go to `https://registry-dev.cigna.com/user/<LANID>/?tab=settings`, generate an encrypted password, then:
   ```bash
   docker login -u='<LANID>' -p='<encrypted-password>' registry-dev.cigna.com
   ```

2. **Checkout staging branch** in the service repo:
   ```bash
   git checkout staging && git pull origin staging
   ```

3. **Create secret file** with your GitHub PAT in the service repo root:
   ```bash
   echo "your_github_token_here" > secret.txt
   ```

### Build & Push

```bash
docker buildx build --push \
  -f Dockerfile.dev \
  --secret id=github_access_token,src=./secret.txt \
  -t registry-dev.cigna.com/mdlive-dev/<service>:latest \
  .
```

With additional tags:
```bash
docker buildx build --push \
  -f Dockerfile.dev \
  --secret id=github_access_token,src=./secret.txt \
  -t registry-dev.cigna.com/mdlive-dev/<service>:latest \
  -t registry-dev.cigna.com/mdlive-dev/<service>:v1.2.3 \
  -t registry-dev.cigna.com/mdlive-dev/<service>:staging \
  .
```

### Cleanup

```bash
rm secret.txt
```

## Initial Setup (first time)

1. Install Docker Desktop (do **not** log in to Docker)
2. Login to Quay registry (see above)
3. Create a GitHub PAT with scopes: `repo`, `workflow`, `read:packages`, `write:packages`, `read:org`, `gist`, `read:user`, `user:email` — authorize with MDLive SSO
4. Clone this repo, copy `.env.template` to `.env`, add your GitHub PAT
5. `make clone-all` — clones all service repos
6. Add `/etc/hosts` entries:
   ```
   127.0.0.1 mdlive.dev
   127.0.0.1 af.mdlive.dev
   127.0.0.1 csa.mdlive.dev
   127.0.0.1 patient.mdlive.dev
   127.0.0.1 provider.mdlive.dev
   127.0.0.1 rest.mdlive.dev
   ```
