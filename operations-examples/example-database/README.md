
# [CrunchyData Postgres Operator](https://access.crunchydata.com/documentation/postgres-operator/v5/)

PGO, the Postgres Operator from Crunchy Data, gives you a declarative Postgres solution that automatically manages your PostgreSQL clusters.

## Getting started

### Create a Minio tenant for backups to live in

1. Pull the latest stable [Minio tenant Helm chart](https://min.io/docs/minio/kubernetes/upstream/operations/install-deploy-manage/deploy-operator-helm.html#deploy-a-tenant) into this repository.
    - `curl -O https://raw.githubusercontent.com/minio/operator/master/helm-releases/tenant-5.0.5.tgz`
    - `mkdir -p ./helm`
    - `tar -zxvf tenant-5.0.5.tgz -C helm/`
    - `rm tenant-5.0.5.tgz`

2. Render the initial Helm charts.
```
mkdir -p ./example-database/charts
pushd helm/tenant
helm template example-database-backup . \
    --namespace example-database \
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
    --set-string tenant.buckets[0].name=example-database-backup \
    > ../../charts/example-database-backup.yaml
popd
```

3. Apply the Kubernetes chart
    - `pushd ./charts/`
    - `kubectl apply -k ./`
    - `popd`

4. Login to the [Minio Tenant console](https://example-database-backup.home.arpa/)
    - Login with the credentials specified in `./charts/example-database-backup.yaml`
        - `export MINIO_ROOT_USER="minio"`
        - `export MINIO_ROOT_PASSWORD="minio123"`


### Postgres Instance

**NOTE:** This is dependent on the Postgres Operator being installed. See the [Postgres Operator README](../../operations/data/README.md).

1. Kustomize and apply the Postgres instance
    - `pushd ./charts/`
    - `kubectl apply -k ./`
    - `popd`

2. Check the status of Postgres
    - `kubectl -n example-database describe postgrescluster example-database`

3. Log into Postgres
- Get connection details:
```
export HOST="`kubectl -n example-database get secret example-database-pguser-example-database -o yaml | grep '\shost:' | awk '{print $NF}' | base64 --decode`"
export USER="`kubectl -n example-database get secret example-database-pguser-example-database -o yaml | grep '\suser:' | awk '{print $NF}' | base64 --decode`"
export PASSWORD="`kubectl -n example-database get secret example-database-pguser-example-database -o yaml | grep '\spassword:' | awk '{print $NF}' | base64 --decode`"
```

- Print connection details:
```
echo $HOST
echo $USER
echo $PASSWORD
```

- Connect to a database replica:
```
# Connect to database replica:
kubectl -n example-database exec -it service/example-database-replicas -- bash

# Connect to database using psql client:
psql --host=example-database-primary.example-database.svc --username=example-database --password
# Enter password when prompted

# List databases:
\list

# Quit psql:
\q
```

### Backups & restoration

Crunchydata has excellent guides on taking backups and restoring. See below:
- [Taking a one-off backup](https://access.crunchydata.com/documentation/postgres-operator/v5/tutorial/backup-management/#taking-a-one-off-backup)
- [Clone a Postgres cluster from backup](https://access.crunchydata.com/documentation/postgres-operator/5.3.2/tutorial/disaster-recovery/#clone-a-postgres-cluster)
- [Perform a point in time recovery](https://access.crunchydata.com/documentation/postgres-operator/5.3.2/tutorial/disaster-recovery/#perform-a-point-in-time-recovery-pitr)
- [Perform an in-place point in time recovery](https://access.crunchydata.com/documentation/postgres-operator/5.3.2/tutorial/disaster-recovery/#perform-an-in-place-point-in-time-recovery-pitr)
- [Restore individual databases](https://access.crunchydata.com/documentation/postgres-operator/5.3.2/tutorial/disaster-recovery/#restore-individual-databases)

