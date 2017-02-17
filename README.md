# Reactor
### Download & Install

Download and install [Vagrant](https://www.vagrantup.com/), [VirtualBox](https://www.virtualbox.org/wiki/Downloads), and [Docker](https://www.docker.com/products/overview)

```
git clone https://github.com/WhatsMyCut/reactor.git
cd reactor
vagrant box add ubuntu/trusty64 #this will take a while
```

### Development

#### Create the Vagrantfile

This repo comes with an example Vagrantfile. To use it as is simply copy it

```
# bash
cp Vagrantfile.example Vagrantfile
```

#### Add ssh keys from the host machine
Run `ssh-add` on the host machine prior to starting the guest machine to ensure the ssh keys of the host machine are accessible by Vagrant and inside the guest machine.

#### Start the Vagrant virtual box

```
vagrant up #this will take a while
```

#### SSH into the vagrant machine:

```
vagrant ssh
```
The `u235core` and `u235ctrl` repos will be cloned into `repos` within the `u235` project during Vagrant provisioning.

#### Insde the Vagrant machine:

When Docker containers are run via docker-compose a new network is created for the services within the docker-compose.yml. To allow containers from different projects to communicate they need to be a part of the same network.

To assist with orchestrating this an `u235` docker network will be created as part of provisioning for the VM. `u235` projects that use docker should have configuration that makes use of that network. If it does not set:
```
docker network create u235
```
[View an example docker-compose.yml](examples/docker-compose-example.yml)

Once containers are in the same network they can be referenced by others using their container name or container id. (i.e. curl u235email/health). Unfortunately docker doesn't handle duplicate container names for you so you must stop and remove existing containers with the desired name before starting new ones.

This repo provides a couple of scripts, `u235dev`, which launches containers for development (with a bash shell)

To work on u235core, for example:
```
cd /vagrant/repos/u235core
```
#### FIRST RUN: set up the docker container
```
docker-compose build # this will take a while
```
#### Start the development environment:
Now, start the container instances:
```
u235dev u235core
```

