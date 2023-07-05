
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

1. Install the CNI network plugins on the host OS:
    - `sudo mkdir -p /opt/cni/bin`
    - `sudo chown -R "$(id -u):$(id -g)" /opt/cni`
    - `pushd /tmp`
    - `curl -O -L https://github.com/containernetworking/plugins/releases/download/v1.2.0/cni-plugins-linux-amd64-v1.2.0.tgz`
    - `tar -C /opt/cni/bin -xzf cni-plugins-linux-amd64-v1.2.0.tgz`
    - `rm cni-plugins-linux-amd64-v1.2.0.tgz`
    - `popd`

2. Create a new image registry:
    - `ctlptl create registry ctlptl-registry --port=5005`

3. Create your dev cluster, referencing your local image registry:
    - `ctlptl apply -f ctlptl-cluster.yaml`

4. Set your local context
    - `kubectl config set-context kind-kind`

5. Install the [Flannel CNI](https://github.com/flannel-io/flannel#getting-started-on-kubernetes)
    - `kubectl create ns kube-flannel`
    - `kubectl label --overwrite ns kube-flannel pod-security.kubernetes.io/enforce=privileged`
    - `helm repo add flannel https://flannel-io.github.io/flannel/`
    - `helm upgrade -i flannel --set podCidr="10.96.0.0/16" --set flannel.backend="host-gw" --namespace kube-flannel flannel/flannel`
    - `kubectl -n kube-system rollout restart deployment coredns`

6. Configure the network for [metallb ipvs](https://metallb.org/installation/)
```
kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl apply -f - -n kube-system
```

7. Start Tilt:
    - `tilt up --file Tiltfile.operations`

8. Visit local environments, make changes, and refresh these pages after builds deploy through Tilt:
    - [identity/keycloak](http://localhost:8080/)


## Cleanup

1. Close Tilt:
    - `[CTRL]` + `[C]`

2. Delete your dev cluster:
    - `ctlptl delete -f ctlptl-cluster.yaml`

3. Delete your local image repository:
    - `ctlptl delete registry ctlptl-registry`

4. Prune dangling Docker images:
    - `docker image prune -a`
