
# [Vault](https://www.hashicorp.com/products/vault)

Manage access to secrets and protect sensitive data

## Getting started

1. Pull the latest stable [Vault Helm chart](https://developer.hashicorp.com/vault/docs/platform/k8s/helm) into this repository.
    - `helm repo add hashicorp https://helm.releases.hashicorp.com`
    - `helm repo update`
    - `helm search repo hashicorp/vault`
    - `helm pull hashicorp/vault`
    - `mkdir -p ./helm`
    - `tar -zxvf vault-0.24.1.tgz -C helm/`
    - `rm vault-0.24.1.tgz`
2. Render the initial `helm` chart.
    - Note that this initializes Vault in "dev" mode, so that it doesn't need to initialize
        - This means it is insecure by default as this Helm chart is rendered
    - `mkdir -p vault/charts`
    - `pushd helm/vault`
    - `helm template vault . --namespace secrets --set server.dev.enabled=true > ../../vault/charts/vault.yaml`
    - `popd`
3. Kustomize and apply the Kubernetes chart
    - `pushd ./vault/charts/`
    - `kubectl apply -k ./`
    - `popd`
4. Initialize Vault
    - NOTE: This step is only necessary for production builds. The dev installation unseals automatically, though this isn't secure and shouldn't run that way in production.
    - `kubectl -n secrets exec -ti vault-0 -- vault operator init -format="yaml" > key-shares.secret`
5. Unseal Vault
    - NOTE: This step is only necessary for production builds. The dev installation unseals automatically, though this isn't secure and shouldn't run that way in production.
    - `cat key-shares.secret`
    - Unseal keys one by one until Vault unseals:
        - `kubectl -n secrets exec -ti vault-0 -- vault operator unseal`
        - `kubectl -n secrets exec -ti vault-0 -- vault operator unseal`
        - `kubectl -n secrets exec -ti vault-0 -- vault operator unseal`
    - You'll need to pass the keys in as input
6. Login to [Vault](http://localhost:8200/)
    - Use the `Initial Root Token` from `key-shares.secret` to login


**TODO: This README currently is setup to run Vault in a dev context, and doesn't include
instructions for securely distributing the keys. If the keys from step #4 are lost, Vault
contents will be lost if Vault is restarted or reset**

**TODO: This README currently runs Vault in dev mode, which is insecure by default, but which
can start without requiring Vault to initialize or unseal, making it easier to play with.**
