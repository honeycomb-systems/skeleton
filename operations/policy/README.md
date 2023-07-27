
# [Kyverno](https://kyverno.io/docs/)

Kyverno is a policy engine designed for Kubernetes

## Getting started

1. Kustomize and apply the Vault Helm chart
    - `pushd ./kyverno/charts/`
    - `kubectl apply -k ./`
    - `popd`
2. View [Kyverno reports](https://kyverno.io/docs/policy-reports/)
    - `kubectl get policyreport -A`


## Troubleshooting

Some Kyverno pods don't start up right away, it may be necessary to restart these pods in order for them to run successfully.
