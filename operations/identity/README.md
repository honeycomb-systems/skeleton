
# [Keycloak](https://www.keycloak.org/)

Open source identity and access management

## Getting started

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

