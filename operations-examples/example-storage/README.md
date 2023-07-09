
# [Minio Object Storage for Kubernetes](https://min.io/docs/minio/kubernetes/upstream/index.html)

MinIO is an object storage solution that provides an Amazon Web Services S3-compatible API and supports all core S3 features.

## Getting started

Note that before you can create Minio tenants in a cluster, the operator needs to be installed. See the [Storage README](/operations/storage/README.md) for more details.

### Creating a Minio Tenant

1. Pull the latest stable [Minio tenant Helm chart](https://min.io/docs/minio/kubernetes/upstream/operations/install-deploy-manage/deploy-operator-helm.html#deploy-a-tenant) into this repository.
    - `curl -O https://raw.githubusercontent.com/minio/operator/master/helm-releases/tenant-5.0.5.tgz`
    - `mkdir -p ./helm`
    - `tar -zxvf tenant-5.0.5.tgz -C helm/`
    - `rm tenant-5.0.5.tgz`

2. Render the initial Helm charts.
```
mkdir -p tenants/example-storage/charts
pushd helm/tenant
helm template example-storage . \
    --namespace example-storage \
    --set tenant.pools[0].size='1Gi' \
    --set-string tenant.buckets[0].name=example-storage-bucket \
    > ../../charts/example-storage.yaml
popd
```

3. Apply the Kubernetes chart
    - `pushd ./charts/`
    - `kubectl apply -k ./`
    - `popd`

4. Login to the [Minio Tenant console](https://localhost:9443/)
    - `kubectl -n example-storage port-forward service/myminio-console 9443:9443`
    - Login with the credentials specified in `./charts/example-storage.yaml`
        - `export MINIO_ROOT_USER="minio"`
        - `export MINIO_ROOT_PASSWORD="minio123"`
