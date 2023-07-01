
# Prerequisites

## Dev

1. Change the default setting for open file limits. Emulating a meaningfully complex k8s cluster in local will require more than a typical user.
```
grep '* soft nofile 256000' /etc/security/limits.conf \
    || echo '* soft nofile 256000' | sudo tee -a /etc/security/limits.conf
grep '* hard nofile 256000' /etc/security/limits.conf \
    || echo '* hard nofile 256000' | sudo tee -a /etc/security/limits.conf

grep 'fs.file-max=256000' /etc/sysctl.conf \
    || echo 'fs.file-max=256000' | sudo tee -a /etc/sysctl.conf

grep 'DefaultLimitNOFILE=256000' /etc/systemd/system.conf \
    || echo 'DefaultLimitNOFILE=256000' | sudo tee -a /etc/systemd/system.conf
grep 'DefaultLimitNOFILE=256000' /etc/systemd/user.conf \
    || echo 'DefaultLimitNOFILE=256000' | sudo tee -a /etc/systemd/user.conf
```

*NOTE: You'll need to log out and log back in for these changes to be applied, since any active sessions will remember the values they started with.*

Verify with `ulimit -a`, or specifically with `ulimit -Sn`, and `ulimit -Hn`.

2. Install [Docker Engine](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository). We need the Docker Engine to run containerized apps in dev.

```
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

*NOTE: If you get an errr installing `docker-ce`, try rebooting your machine and reattempting the install command.*

Verify with `sudo docker run hello-world`.

3. Setup Docker as a [non-root user](https://docs.docker.com/engine/install/linux-postinstall/). We need Docker to be usable from our normal user in order to be able to leverage Tilt to run our local k8s cluster.

    - `sudo groupadd docker || true`
    - `sudo usermod -aG docker $USER`
    - `newgrp docker`
    - You may need to log out and log back in for the changes to be persistent.

Verify with `docker run hello-world`.

4. Install [https://kubernetes.io/docs/tasks/tools/](kubectl). We need `kubectl` in order to debug our local k8s cluster.

```
sudo apt-get update
sudo apt-get install -y ca-certificates curl
sudo apt-get install -y apt-transport-https
curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg \
    | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-archive-keyring.gpg
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" \
    | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl
```

5. Install [Helm](https://helm.sh/docs/intro/install/). We need `helm` for k8s package management.
    - Find the URL for the [latest stable Helm release](https://github.com/helm/helm/releases)
    - `pushd /tmp`
    - `wget https://get.helm.sh/helm-v3.12.1-linux-amd64.tar.gz`
    - `tar -zxvf helm-v3.12.1-linux-amd64.tar.gz`
    - `mv linux-amd64/helm /usr/local/bin/helm`
    - `rm helm-v3.12.1-linux-amd64.tar.gz`
    - `rm -rf linux-amd64/`
    - `popd`

6. Install [Go Version Manager (gvm)](https://github.com/moovweb/gvm). We need a Go version manager in order to install or upgrade Go for this project.

    - `sudo apt-get install curl git mercurial make binutils bison gcc build-essential`
    - `bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)`
    - `source ~/.gvm/scripts/gvm`

7. Install [Go](https://go.dev/), We need Go in order to install other dependencies and run our dev loop.
    - `gvm listall`
    - `gvm install go1.20.5 -B`
    - `gvm list`
    - `gvm use go1.20.5 --default`

8. Install [Kind](https://kind.sigs.k8s.io/docs/user/quick-start/). Kind is used to run a local k8s cluster.
    - `go install sigs.k8s.io/kind@v0.20.0`

9. Install [Cattle Patrol (ctlptl)](https://github.com/tilt-dev/ctlptl). Cattle patrol is the tool we'll use to administer, create, and destroy local k8s clusters & Docker image repositories.
    - `go install github.com/tilt-dev/ctlptl/cmd/ctlptl@latest`
    - `ctlptl analytics opt out`

10. Install [Tilt.dev](https://docs.tilt.dev/). Tilt will act as the interface to hot-reload code in our local k8s cluster as we make changes.
    - `curl -fsSL https://raw.githubusercontent.com/tilt-dev/tilt/master/scripts/install.sh | bash`

11. [Optional] Install [Node Version Manager](https://github.com/nvm-sh/nvm). This will make it easier to develop Node.js services.
    - `curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash`
    - `export NVM_DIR="$HOME/.nvm"`
    - `[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm`
    - `[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"`

12. [Optional] Install [Python Venv](https://docs.python.org/3/library/venv.html). This will make it easier to develop Python services.
    - `sudo apt-get install python3 python3-venv`

13. [Optional] Install [yq](https://github.com/mikefarah/yq/#install). This will make it easier to develop YAML charts.
    - `pushd /tmp`
    - Optionally get the [latest release](https://github.com/mikefarah/yq/releases/)
    - `wget https://github.com/mikefarah/yq/releases/download/v4.34.1/yq_linux_amd64`
    - `chmod +x yq_linux_amd64`
    - `sudo mv yq_linux_amd64 /usr/local/bin/yq`
    - `popd`

## Appendix

### Create a dev k8s cluster

This creates the virtual infrastructure to deploy your services on.

1. Create a new image registry:
    - `ctlptl create registry ctlptl-registry --port=5005`

2. Create your dev cluster, referencing your local image registry:
    - `ctlptl apply -f ctlptl-cluster.yaml`

### Manage your dev k8s cluster

This launches Tilt, which will hot-reload your app as you make changes to your codebase locally.

1. Start Tilt:
    - `tilt up`

2. Stop Tilt:
    - `[CTRL]` + `[C]`

### Interact with your dev k8s cluster via kubectl

This can be useful for debugging.

1. Get cluster details
    - `kind get clusters`

2. Interact with the cluster using `kubectl`
    - `kubectl cluster-info --context kind-kind`
    - `kubectl get ns --context kind-kind`

3. Optionally, set context
    - `kubectl config current-context`
    - `kubectl config get-clusters`
    - `kubectl config set-context kind-kind`

### Delete your dev k8s cluster

If you want to stop your k8s cluster or reset it, these commands can be helpful. This is also important for validating the installation & release process.

1. Delete your dev cluster:
    - `ctlptl delete -f ctlptl-cluster.yaml`

2. Delete your local image repository:
    - `ctlptl delete registry ctlptl-registry`

