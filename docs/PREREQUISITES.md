
# Prerequisites

## Dev

1. Install [Docker Engine](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository). We need the Docker Engine to run containerized apps in dev.

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

2. Setup Docker as a [non-root user](https://docs.docker.com/engine/install/linux-postinstall/). We need Docker to be usable from our normal user in order to be able to leverage Tilt to run our local k8s cluster.

    - `sudo groupadd docker || true`
    - `sudo usermod -aG docker $USER`
    - `newgrp docker`
    - You may need to log out and log back in for the changes to be persistent.

Verify with `docker run hello-world`.

3. Install [https://kubernetes.io/docs/tasks/tools/](kubectl). We need `kubectl` in order to debug our local k8s cluster.

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

4. Install [Go Version Manager (gvm)](https://github.com/moovweb/gvm). We need a Go version manager in order to install or upgrade Go for this project.

    - `sudo apt-get install curl git mercurial make binutils bison gcc build-essential`
    - `bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)`
    - `source ~/.gvm/scripts/gvm`

5. Install [Go](https://go.dev/), We need Go in order to install other dependencies and run our dev loop.
    - `gvm listall`
    - `gvm install go1.20.5 -B`
    - `gvm list`
    - `gvm use go1.20.5 --default`

6. Install [Kind](https://kind.sigs.k8s.io/docs/user/quick-start/). Kind is used to run a local k8s cluster.
    - `go install sigs.k8s.io/kind@v0.20.0`

7. Install [Cattle Patrol (ctlptl)](https://github.com/tilt-dev/ctlptl). Cattle patrol is the tool we'll use to administer, create, and destroy local k8s clusters & Docker image repositories.
    - `go install github.com/tilt-dev/ctlptl/cmd/ctlptl@latest`
    - `ctlptl analytics opt out`

8. Install [Tilt.dev](https://docs.tilt.dev/). Tilt will act as the interface to hot-reload code in our local k8s cluster as we make changes.
    - `curl -fsSL https://raw.githubusercontent.com/tilt-dev/tilt/master/scripts/install.sh | bash`

9. [Optional] Install [Node Version Manager](https://github.com/nvm-sh/nvm). This will make it easier to develop Node.js services.
    - `curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash`
    - `export NVM_DIR="$HOME/.nvm"`
    - `[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm`
    - `[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"`

10. [Optional] Install [Python Venv](https://docs.python.org/3/library/venv.html). This will make it easier to develop Python services.
    - `sudo apt-get install python3 python3-venv`

## Appendix

### Create a dev k8s cluster

This creates the virtual infrastructure to deploy your services on.

1. Create a new image registry:
    - `ctlptl create registry ctlptl-registry --port=5005`

2. Create your dev cluster, referencing your local image registry:
    - `ctlptl create cluster kind --registry=ctlptl-registry`

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
    - `ctlptl delete cluster kind`

2. Delete your local image repository:
    - `ctlptl delete registry ctlptl-registry`
