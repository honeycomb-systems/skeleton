
# [ArgoCD](https://argo-cd.readthedocs.io/en/stable/)

Argo CD is a declarative, GitOps continuous delivery tool for Kubernetes.

## Getting started

### Install ArgoCD

1. Kustomize and apply the Kubernetes chart
    - `kubectl apply -k ./`
2. Login:
    - Login to [ArgoCD](https://delivery.home.arpa/)
        - Use the username `admin`
        - Use the password from `kubectl -n delivery get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo`
