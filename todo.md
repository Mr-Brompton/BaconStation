# [DONE] Install Docker

Add Dockers repository and GPG key

```sh
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
```

```sh
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

```sh
 sudo docker run hello-world
```

to Avoid repeated sudo's add user to docker group

```sh
sudo usermod -a -G docker $USER
```


# [DONE] Install Mongosh

Add mongo GPG key

```sh
wget -qO- https://www.mongodb.org/static/pgp/server-8.0.asc | sudo tee /etc/apt/trusted.gpg.d/server-8.0.asc
```

Check Ubuntu and openSSL Version
```sh
lsb_release -dc
openssl version
```
Create source list file
```sh
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu noble/mongodb-org/8.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-8.0.list
```

APT update
```sh
sudo apt-get update
```
install mongosh with shared openssl3 libraries
```sh
sudo apt-get install -y mongodb-mongosh-shared-openssl3
```

verify
```sh
mongosh --version
```

# [TODO] pull and run MONGO container
Pull Image
```sh
docker pull mongodb/mongodb-community-server:latest
```

```sh
docker run --name mongodb -p 27017:27017 -d mongodb/mongodb-community-server:5.0-ubuntu2004
```

Check container is runnning
```sh
docker container ls
```

connect to container with mongosh
```sh
mongosh --port 27017
```


build database
build grafana container
connect grafana with mongo
build dashboard
