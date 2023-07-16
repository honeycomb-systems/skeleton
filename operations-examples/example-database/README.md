
# [CrunchyData Postgres Cluster](https://access.crunchydata.com/documentation/postgres-operator/v5/)

PGO, the Postgres Operator from Crunchy Data, gives you a declarative Postgres solution that automatically manages your PostgreSQL clusters.

## Getting started

### Postgres Cluster & backup storage tenant

**NOTE:** This is dependent on the Minio Operator being installed. See the [Storage README](/operations/storage/README.md) for more details.

**NOTE:** This is dependent on the Postgres Operator being installed. See the [Data README](../../operations/data/README.md).

1. Kustomize and apply the Postgres cluster
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

4. [Optional] Login to the [Backup storage tenant console](https://example-database-backup.home.arpa/)
    - Login with the default credentials specified in `./charts/kustomization.yaml`:
        - `accessKey: minio`
        - `secretKey: minio123`


### Backups & restoration

Crunchydata has excellent guides on taking backups and restoring. See below:
- [Taking a one-off backup](https://access.crunchydata.com/documentation/postgres-operator/v5/tutorial/backup-management/#taking-a-one-off-backup)
- [Clone a Postgres cluster from backup](https://access.crunchydata.com/documentation/postgres-operator/5.3.2/tutorial/disaster-recovery/#clone-a-postgres-cluster)
- [Perform a point in time recovery](https://access.crunchydata.com/documentation/postgres-operator/5.3.2/tutorial/disaster-recovery/#perform-a-point-in-time-recovery-pitr)
- [Perform an in-place point in time recovery](https://access.crunchydata.com/documentation/postgres-operator/5.3.2/tutorial/disaster-recovery/#perform-an-in-place-point-in-time-recovery-pitr)
- [Restore individual databases](https://access.crunchydata.com/documentation/postgres-operator/5.3.2/tutorial/disaster-recovery/#restore-individual-databases)


#### Backup Storage Tenant Reference

- [Minio tenant installation](https://min.io/docs/minio/kubernetes/upstream/operations/install-deploy-manage/deploy-operator-helm.html#deploy-a-tenant)
