---
name: mdlive-dev
description: Manage the MDLive local Docker Compose development environment. Use when starting/stopping MDLive services (stern, csa, rest-api, affiliation-manager, patient-portal, provider-portal, legacy), running DB migrations, debugging with Byebug, building/pushing Docker images to Quay, or looking up service URLs and dev credentials.
---

# MDLive Dev Environment

Repo: `~/projects/mdlive-dev-environment`  
All `make` commands must be run from that directory.

## Quick Reference

| Service             | Alias | Direct URL              | Nginx URL                        |
|---------------------|-------|-------------------------|----------------------------------|
| Stern               | stern | http://localhost:3001   | https://mdlive.dev               |
| CSA                 | csa   | http://localhost:3003   | https://csa.mdlive.dev           |
| Rest API            | api   | http://localhost:3005   | https://rest.mdlive.dev          |
| Affiliation Manager | afm   | http://localhost:3007   | https://af.mdlive.dev            |
| Patient Portal      | pap   | http://localhost:3000   | https://patient.mdlive.dev       |
| Provider Portal     | prp   | http://localhost:3004   | https://provider.mdlive.dev      |
| Legacy              | legacy| http://localhost:3002   | https://members.mdlive.dev       |
| RabbitMQ Mgmt       | —     | http://localhost:15672  | —                                |

**Dev logins** (swap trailing number 1–25, e.g. `demopatient1`…`demopatient25`):

| Service           | Username      | Password    |
|-------------------|---------------|-------------|
| MDLive (patient)  | demopatient1  | Mdlive123!  |
| MDLive (provider) | demoprovider1 | Mdlive123!  |
| MDLive (CSA)      | democsa1      | Mdlive123!  |
| RabbitMQ          | guest         | guest        |

## Common Workflows

See [REFERENCE.md](REFERENCE.md) for full details.

### Start / stop a service
```bash
make <service>          # start (with deps)
make <service>-stop     # stop
make <service>-restart  # restart
```

### Database
```bash
make stern-db-setup       # initial Stern DB setup (dev + test)
make stern-db-migrate     # run migrations
make <service>-init       # bundle install + db setup (afm, csa, etc.)
make affiliation-manager-init   # afm alias: make afm-init
```

### Shell / console / logs
```bash
make <service>-bash       # bash shell in container
make <service>-console    # Rails console
make <service>-logs       # tail logs
make <service>-attach     # attach (for Byebug — detach with Ctrl-p Ctrl-q)
```

### Build image
```bash
make <service>-build      # build local image
make <service>-rebuild    # tear down + rebuild
```

### Byebug debugging
1. `docker compose attach <service>` — attach to running container
2. Send a request that hits your breakpoint
3. Interact with Byebug normally
4. **Detach**: `Ctrl-p Ctrl-q` (never `Ctrl-c` — that stops the container)

### Shell aliases (one-time setup)
```bash
make shell-config   # prints config to paste into ~/.zshrc or ~/.bashrc
```
