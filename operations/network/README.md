
# [Istio](https://istio.io/latest/)

Enable a service mesh and network proxy for services running in the k8s cluster.

## Getting started

1. You may need to adjust the IP address range in `./metallb/charts/metallb-conf.yaml` depending on your local Docker config:
    - `docker network inspect -f '{{.IPAM.Config}}' kind`
    - Be sure the IP range selected in `metallb-conf.yaml` is a subset of the Docker network range

2. Kustomize and apply the Kubernetes charts
    - `kubectl apply -k ./metallb/charts/`
    - `kubectl apply -k ./istio/charts/`

3. Visit sites from the local load balancer:
    - `kubectl -n network get services`
    - Assuming load balancer IP is `172.18.255.200`, visit [https://172.18.255.200/](https://172.18.255.200/)
        + Note that this will only work if you have a site configured with an Istio Gateway + VirtualService

## Appendix

This was quite difficult to generate via Helm. To troubleshoot, I recommend the following loop:

1. Generate a manifest with Istioctl:
    - `istioctl manifest generate --set profile=default --set values.global.istioNamespace=network > /tmp/istio.yaml`
2. Generate a manfiest with Kustomize & Helm:
    - `kubectl kustomize --enable-helm ./ > /tmp/istio-helm.yaml`
3. Use Istioctl to compare the two:
    - `istioctl manifest diff /tmp/istio.yaml /tmp/istio-helm.yaml`
