
# [Minio Object Storage for Kubernetes](https://min.io/docs/minio/kubernetes/upstream/index.html)

MinIO is an object storage solution that provides an Amazon Web Services S3-compatible API and supports all core S3 features.

## Getting started

Note that installing the MinIO operator is just a prerequisite to creating S3-api-compatible storage repositories. See the [example storage README](/operations-examples/example-storage/README.md) for more details.

### Installing the Minio Operator

1. Apply the Kubernetes chart
    - `pushd ./minio/charts/`
    - `kubectl apply -k ./`
    - `popd`

2. Login to the [Minio Operator console](https://storage.home.arpa/)
    - Use this token to login:
        - `kubectl -n storage get secret console-sa-secret -o jsonpath="{.data.token}" | base64 --decode`

### Reference

- [Minio operator installation](https://min.io/docs/minio/kubernetes/upstream/operations/install-deploy-manage/deploy-operator-helm.html#install-operator)
