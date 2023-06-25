
# [Keycloak](https://www.keycloak.org/)

Open source identity and access management

## Getting started

1. Pull the latest stable Keycloak deployment and service into this repository.
    - `cd charts/`
    - `wget https://raw.githubusercontent.com/keycloak/keycloak-quickstarts/latest/kubernetes-examples/keycloak.yaml`
2. Kustomize and apply the Kubernetes chart
    - `kubectl apply -k ./`
