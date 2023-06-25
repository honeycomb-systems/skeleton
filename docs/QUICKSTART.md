
# Quickstart

Before you can follow the quickstart guide, you'll need to complete the [prerequisites](./PREREQUISITES.md) for setting up your local dev environment.

## Examples

1. Create a new image registry:
    - `ctlptl create registry ctlptl-registry --port=5005`

2. Create your dev cluster, referencing your local image registry:
    - `ctlptl create cluster kind --registry=ctlptl-registry`

3. Set your local context
    - `kubectl config set-context kind-kind`

4. Start Tilt:
    - `tilt up --file Tiltfile.examples`

5. Visit local environments, make changes, and refresh these pages after builds deploy through Tilt:
    - [express-hello-world](http://localhost:3000/)
    - [flask-hello-world](http://localhost:3001/)
    - [go-hello-world](http://localhost:3002/)

## Operations

1. Create a new image registry:
    - `ctlptl create registry ctlptl-registry --port=5005`

2. Create your dev cluster, referencing your local image registry:
    - `ctlptl create cluster kind --registry=ctlptl-registry`

3. Set your local context
    - `kubectl config set-context kind-kind`

4. Start Tilt:
    - `tilt up --file Tiltfile.operations`

5. Visit local environments, make changes, and refresh these pages after builds deploy through Tilt:
    - [identity/keycloak](http://localhost:8080/)


## Cleanup

1. Close Tilt:
    - `[CTRL]` + `[C]`

2. Delete your dev cluster:
    - `ctlptl delete cluster kind`

3. Delete your local image repository:
    - `ctlptl delete registry ctlptl-registry`

4. Prune dangling Docker images:
    - `docker image prune -a`
