
# [CrunchyData Postgres Operator](https://access.crunchydata.com/documentation/postgres-operator/v5/)

PGO, the Postgres Operator from Crunchy Data, gives you a declarative Postgres solution that automatically manages your PostgreSQL clusters.

## Getting started

### Postgres Operator

1. Pull the latest stable operator deployment into this repository
    - `pushd /tmp`
    - `git clone --depth=1 git@github.com:CrunchyData/postgres-operator-examples.git`
    - `popd`
    - `mkdir -p postgres-operator/`
    - `mv /tmp/postgres-operator-examples/kustomize/install postgres-operator/charts`
    - `sed -i 's/namespace: postgres-operator/namespace: data/g' postgres-operator/charts/default/kustomization.yaml`
    - `rm -rf postgres-operator/charts/namespace`
    - `rm -rf postgres-operator/charts/singlenamespace`

2. Kustomize and apply the Kubernetes chart
    - `kubectl apply --server-side -k ./postgres-operator/charts/default`

### Postgres Instance

TODO
