
# [Vault](https://www.hashicorp.com/products/vault)

Manage access to secrets and protect sensitive data

## Getting started

1. Kustomize and apply the Vault Helm chart
    - `pushd ./vault/charts/`
    - NOTE: This currently installs vault in an insecure way, running as a dev server:
        - `kubectl apply -k ./`
    - `popd`
2. Initialize Vault
    - **NOTE: This step is only necessary for production builds.**
        - The dev installation initializes automatically, though this is insecure.
    - `kubectl -n secrets exec -ti vault-0 -- vault operator init -format="yaml" > key-shares.secret`
3. Unseal Vault
    - **NOTE: This step is only necessary for production builds.**
        - The dev installation unseals automatically, though this is insecure.
    - `cat key-shares.secret`
    - Unseal keys one by one until Vault unseals:
        - `kubectl -n secrets exec -ti vault-0 -- vault operator unseal`
        - `kubectl -n secrets exec -ti vault-0 -- vault operator unseal`
        - `kubectl -n secrets exec -ti vault-0 -- vault operator unseal`
    - You'll need to pass the keys in as input
4. Login to [Vault](https://secrets.home.arpa/)
    - **Production:**
        - Use the `Initial Root Token` from `key-shares.secret` to login
    - **Development:**
        - Use `root` as the token to login with

**TODO: This README currently is setup to run Vault in a dev context, and doesn't include
instructions for securely distributing the keys. If the keys from step #4 are lost, Vault
contents will be lost if Vault is restarted or reset**

**TODO: This README currently runs Vault in dev mode, which is insecure by default, but which
can start without requiring Vault to initialize or unseal, making it easier to play with.**
