
# [Istio](https://istio.io/latest/)

Manage access to secrets and protect sensitive data

## Getting started

1. Generate Istio manifests
    - `mkdir -p ./istio/charts/`
    - `pushd ./istio/charts/`
    - `istioctl manifest generate > ./istio.yaml`
    - `popd`

2. Get plugins for the current version of Istio
```
export ISTIO_VERSION="`/usr/local/bin/istioctl version 2>/dev/null | head -n 1 | awk '{print $NF}' | awk -F'.' '{print $1 "." $2}'`"
```
3. Get the charts for the desired Istio plugins
    - `mkdir -p ./jaeger/charts/`
    - `pushd ./jaeger/charts/`
    - `wget "https://raw.githubusercontent.com/istio/istio/release-${ISTIO_VERSION}/samples/addons/jaeger.yaml"`
    - `popd`

    - `mkdir -p ./kiali/charts/`
    - `pushd ./kiali/charts`
    - `wget https://raw.githubusercontent.com/istio/istio/release--${ISTIO_VERSION}/samples/addons/kiali.yaml`
    - `popd`

    - `mkdir -p ./prometheus/charts/`
    - `pushd ./prometheus/charts/`
    - `wget "https://raw.githubusercontent.com/istio/istio/release-${ISTIO_VERSION}/samples/addons/prometheus.yaml"`
    - `popd`

4. Get the chart for a [Kind k8s cluster load balancer](https://kind.sigs.k8s.io/docs/user/loadbalancer/)
    - `mkdir -p ./metallb/charts/`
    - `pushd ./metallb/charts/`
    - `wget https://raw.githubusercontent.com/metallb/metallb/v0.13.7/config/manifests/metallb-native.yaml`
    - kubectl apply -f https://kind.sigs.k8s.io/examples/loadbalancer/metallb-config.yaml
    - `popd`

5. You may need to adjust the IP address range in `./metallb/charts/metallb-conf.yaml` depending on your local Docker config:
    - `docker network inspect -f '{{.IPAM.Config}}' kind`
    - Be sure the IP range selected in `metallb-conf.yaml` is a subset of the Docker network range

6. Kustomize and apply the Kubernetes charts
    - `kubectl apply -k ./metallb/charts/`

    - `kubectl apply -k ./istio/charts/`
    - `kubectl apply -k ./jaeger/charts/`
    - `kubectl apply -k ./kiali/charts/`
    - `kubectl apply -k ./prometheus/charts/`

