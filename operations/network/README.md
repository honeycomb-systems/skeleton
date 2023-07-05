
# [Istio](https://istio.io/latest/)

Enable a service mesh and network proxy for services running in the k8s cluster.

## Getting started

1. Generate Istio manifests
    - `mkdir -p ./istio/charts/`
    - `pushd ./istio/charts/`
    - `istioctl manifest generate --set profile=default --set values.global.istioNamespace=network-system > ./istio.yaml`
    - `popd`

2. Get the chart for a [Kind k8s cluster load balancer](https://kind.sigs.k8s.io/docs/user/loadbalancer/)
    - `mkdir -p ./metallb/charts/`
    - `pushd ./metallb/charts/`
    - `wget https://raw.githubusercontent.com/metallb/metallb/v0.13.7/config/manifests/metallb-native.yaml`
    - kubectl apply -f https://kind.sigs.k8s.io/examples/loadbalancer/metallb-config.yaml
    - `popd`

3. You may need to adjust the IP address range in `./metallb/charts/metallb-conf.yaml` depending on your local Docker config:
    - `docker network inspect -f '{{.IPAM.Config}}' kind`
    - Be sure the IP range selected in `metallb-conf.yaml` is a subset of the Docker network range

4. Kustomize and apply the Kubernetes charts
    - `kubectl apply -k ./metallb/charts/`
    - `kubectl apply -k ./istio/charts/`

5. Visit sites from the local load balancer:
    - `kubectl -n network-system get services`
    - Assuming load balancer IP is `172.18.255.201`, visit [https://172.18.255.201/](https://172.18.255.201/)
        + Note that this will only work if you have a site configured with an Istio Gateway + VirtualService
