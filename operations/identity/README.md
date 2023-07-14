
# [Keycloak](https://www.keycloak.org/)

Open source identity and access management

## Getting started

### Create a Minio tenant for backups to live in

1. Pull the latest stable [Minio tenant Helm chart](https://min.io/docs/minio/kubernetes/upstream/operations/install-deploy-manage/deploy-operator-helm.html#deploy-a-tenant) into this repository.
    - `curl -O https://raw.githubusercontent.com/minio/operator/master/helm-releases/tenant-5.0.5.tgz`
    - `mkdir -p ./helm`
    - `tar -zxvf tenant-5.0.5.tgz -C helm/`
    - `rm tenant-5.0.5.tgz`

2. Render the initial Helm charts.
```
mkdir -p ./keycloak/charts
pushd helm/tenant
helm template identity-backup . \
    --namespace identity \
    --set tenant.pools[0].containerSecurityContext.runAsGroup=1000 \
    --set tenant.pools[0].containerSecurityContext.runAsNonRoot=true \
    --set tenant.pools[0].containerSecurityContext.runAsUser=1000 \
    --set tenant.pools[0].name='pool-0' \
    --set tenant.pools[0].securityContext.fsGroup=1000 \
    --set tenant.pools[0].securityContext.runAsGroup=1000 \
    --set tenant.pools[0].securityContext.runAsNonRoot=true \
    --set tenant.pools[0].securityContext.runAsUser=1000 \
    --set tenant.pools[0].size='10Gi' \
    --set tenant.pools[0].storageClassName=standard \
    --set-string tenant.buckets[0].name=identity-backup \
    > ../../keycloak/charts/identity-backup.yaml
popd
```

### Install Keycloak

1. Pull the latest stable Keycloak deployment and service into this repository.
    - `cd ./keycloak/charts/`
    - `wget https://raw.githubusercontent.com/keycloak/keycloak-quickstarts/latest/kubernetes-examples/keycloak.yaml`
2. Kustomize and apply the Kubernetes chart
    - `kubectl apply -k ./`
3. Login:
    - Login to [Keycloak](https://identity.home.arpa/)
        - Use `KEYCLOAK_ADMIN` and `KEYCLOAK_ADMIN_PASSWORD` from `./charts/keycloak.yaml` to login
            - `export KEYCLOAK_ADMIN=admin`
            - `export KEYCLOAK_ADMIN_PASSWORD=admin`
    - Login to the [Minio Tenant console](https://identity-backup.home.arpa/)
        - Login with the credentials specified in `./charts/identity-backup.yaml`
            - `export MINIO_ROOT_USER="minio"`
            - `export MINIO_ROOT_PASSWORD="minio123"`

### Backups & restoration

Crunchydata has excellent guides on taking backups and restoring. See below:
- [Taking a one-off backup](https://access.crunchydata.com/documentation/postgres-operator/v5/tutorial/backup-management/#taking-a-one-off-backup)
- [Clone a Postgres cluster from backup](https://access.crunchydata.com/documentation/postgres-operator/5.3.2/tutorial/disaster-recovery/#clone-a-postgres-cluster)
- [Perform a point in time recovery](https://access.crunchydata.com/documentation/postgres-operator/5.3.2/tutorial/disaster-recovery/#perform-a-point-in-time-recovery-pitr)
- [Perform an in-place point in time recovery](https://access.crunchydata.com/documentation/postgres-operator/5.3.2/tutorial/disaster-recovery/#perform-an-in-place-point-in-time-recovery-pitr)
- [Restore individual databases](https://access.crunchydata.com/documentation/postgres-operator/5.3.2/tutorial/disaster-recovery/#restore-individual-databases)

