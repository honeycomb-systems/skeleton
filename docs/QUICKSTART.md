
# Quickstart

Before you can follow the quickstart guide, you'll need to complete the [prerequisites](./PREREQUISITES.md) for setting up your local dev environment.

## Dev

1. Create a new image registry:
    - `ctlptl create registry ctlptl-registry --port=5005`

2. Create your dev cluster, referencing your local image registry:
    - `ctlptl create cluster kind --registry=ctlptl-registry`

3. Set your local context
    - `kubectl config set-context kind-kind`

4. Start Tilt:
    - `tilt up --file Tiltfile.examples`

5. Visit local environments, and make changes to the code for live-reload:
    - http://localhost:3000/

## Cleanup

1. Close Tilt:
    - `[CTRL]` + `[C]`

2. Delete your dev cluster:
    - `ctlptl delete cluster kind`

3. Delete your local image repository:
    - `ctlptl delete registry ctlptl-registry`

4. Prune dangling Docker images:
    - `docker image prune -a`
