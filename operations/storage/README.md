
# [Minio Object Storage for Kubernetes](https://min.io/docs/minio/kubernetes/upstream/index.html)

MinIO is an object storage solution that provides an Amazon Web Services S3-compatible API and supports all core S3 features.

## Getting started

### Installing the Minio Operator

1. Pull the latest stable [Minio operator Helm chart](https://min.io/docs/minio/kubernetes/upstream/operations/install-deploy-manage/deploy-operator-helm.html#install-operator) into this repository.
    - `curl -O https://raw.githubusercontent.com/minio/operator/master/helm-releases/operator-5.0.5.tgz`
    - `mkdir -p ./helm`
    - `tar -zxvf operator-5.0.5.tgz -C helm/`
    - `rm operator-5.0.5.tgz`

2. Render the initial Helm charts.
    - `mkdir -p minio/charts`
    - `pushd helm/operator`
    - `helm template minio-operator . --namespace storage-operator > ../../minio/charts/console.yaml`
    - `popd`

3. Apply the Kubernetes chart
    - `pushd ./minio/charts/`
    - `kubectl apply -f ./console.yaml`
    - `popd`

4. Login to the [Minio Operator console](http://localhost:9090/)
    - Use this token to login:
        - `kubectl -n storage-operator get secret console-sa-secret -o jsonpath="{.data.token}" | base64 --decode`


### Creating a Minio Tenant

1. Pull the latest stable [Minio tenant Helm chart](https://min.io/docs/minio/kubernetes/upstream/operations/install-deploy-manage/deploy-operator-helm.html#install-operator) into this repository.
    - `curl -O https://raw.githubusercontent.com/minio/operator/master/helm-releases/tenant-5.0.5.tgz`
    - `mkdir -p ./helm`
    - `tar -zxvf tenant-5.0.5.tgz -C helm/`
    - `rm tenant-5.0.5.tgz`

2. Render the initial Helm charts.
    - `mkdir -p tenants/storage-main/charts`
    - `pushd helm/tenant`
    - `helm template storage-main . --namespace storage-main > ../../tenants/storage-main/charts/storage-main.yaml`
    - `popd`

3. Apply the Kubernetes chart
    - `pushd ./tenants/storage-main/charts/`
    - `kubectl apply -k ./`
    - `popd`

4. Login to the [Minio Tenant console](https://localhost:9443/)
    - Login with the credentials specified in `./tenants/storage-main/charts/storage-main.yaml`
        - `export MINIO_ROOT_USER="minio"`
        - `export MINIO_ROOT_PASSWORD="minio123"`
