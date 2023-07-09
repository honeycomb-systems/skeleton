
# Quickstart

Before you can follow the quickstart guide, you'll need to complete the [prerequisites](./PREREQUISITES.md) for setting up your local dev environment.


## Examples

1. Create a new image registry:
    - `ctlptl create registry ctlptl-registry --port=5005`

2. Create your dev cluster, referencing your local image registry:
    - `ctlptl apply -f ctlptl-cluster.yaml`

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
    - `ctlptl apply -f ctlptl-cluster.yaml`

3. Set your local context
    - `kubectl config set-context kind-kind`

4. Configure the network for [metallb ipvs](https://metallb.org/installation/)
```
kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl apply -f - -n kube-system
```

5. Start Tilt:
    - `tilt up --file Tiltfile.operations`
        - You will need to initialize Vault, by following the [Secrets README](../operations/secrets/README.md)

6. Visit local environments, make changes, and refresh these pages after builds deploy through Tilt:
    - [identity/keycloak](http://localhost:8080/)
    - [secrets/vault](http://localhost:8200/)
    - [storage/minio](http://localhost:9090/)


## Operations Examples

1. Run the [Operations quickstart](#Operations), and after `tilt up --file Tiltfile.operations`, wait for all apps and services to deploy

2. After everything is running, use `[CTRL]` + `[C]` to stop Tilt. Your operations services will still be running in your local k8s cluster, though they'll no longer automatically sync.

3. Start Tilt to sync the operations examples:
    - `tilt up --file Tiltfile.operations-examples`

4. Visit local environments, make changes, and refresh these pages after builds deploy through Tilt:
    - [storage/minio tenant](http://localhost:9443/)


## Cleanup

1. Close Tilt:
    - `[CTRL]` + `[C]`

2. Delete your dev cluster:
    - `ctlptl delete -f ctlptl-cluster.yaml`

3. Delete your local image repository:
    - `ctlptl delete registry ctlptl-registry`

4. Prune dangling Docker images:
    - `docker image prune -a`
