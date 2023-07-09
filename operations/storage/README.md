
# [Minio Object Storage for Kubernetes](https://min.io/docs/minio/kubernetes/upstream/index.html)

MinIO is an object storage solution that provides an Amazon Web Services S3-compatible API and supports all core S3 features.

## Getting started

Note that installing the MinIO operator is just a prerequisite to creating S3-api-compatible storage repositories. See the [example storage README](/operations-examples/example-storage/README.md) for more details.

### Installing the Minio Operator

1. Pull the latest stable [Minio operator Helm chart](https://min.io/docs/minio/kubernetes/upstream/operations/install-deploy-manage/deploy-operator-helm.html#install-operator) into this repository.
    - `curl -O https://raw.githubusercontent.com/minio/operator/master/helm-releases/operator-5.0.5.tgz`
    - `mkdir -p ./helm`
    - `tar -zxvf operator-5.0.5.tgz -C helm/`
    - `rm operator-5.0.5.tgz`

2. Render the initial Helm charts.
    - `mkdir -p minio/charts`
    - `pushd helm/operator`
    - `helm template minio-operator . --namespace storage > ../../minio/charts/console.yaml`
    - `popd`

3. Apply the Kubernetes chart
    - `pushd ./minio/charts/`
    - `kubectl apply -f ./console.yaml`
    - `popd`

4. Login to the [Minio Operator console](http://localhost:9090/)
    - Use this token to login:
        - `kubectl -n storage get secret console-sa-secret -o jsonpath="{.data.token}" | base64 --decode`

