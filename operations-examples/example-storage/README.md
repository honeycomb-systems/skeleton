
# [Minio Object Storage for Kubernetes](https://min.io/docs/minio/kubernetes/upstream/index.html)

MinIO is an object storage solution that provides an Amazon Web Services S3-compatible API and supports all core S3 features.

## Getting started

Note that before you can create Minio tenants in a cluster, the operator needs to be installed. See the [Storage README](/operations/storage/README.md) for more details.

### Creating a Minio Tenant

1. Apply the Kubernetes chart
    - `pushd ./charts/`
    - `kubectl apply -k ./`
    - `popd`

2. Login to the [Minio Tenant console](https://example-storage.home.arpa/)
    - Login with the default credentials specified in `./charts/kustomization.yaml`:
        - `accessKey: minio`
        - `secretKey: minio123`


### Reference

- [Minio tenant installation](https://min.io/docs/minio/kubernetes/upstream/operations/install-deploy-manage/deploy-operator-helm.html#deploy-a-tenant)
