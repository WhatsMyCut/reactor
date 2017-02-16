#!/bin/bash -e

# update package list
sudo apt-get update

# install some essentials
sudo apt-get install -y g++ build-essential git-core curl vim jq apt-transport-https ca-certificates python-pip

# install docker
wget -qO- https://get.docker.com/ | sh

# install docker compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.9.0/docker-compose-$(uname -s)-$(uname -m)" > docker-compose
sudo mv docker-compose /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# make docker daemon available to the vagrant user
sudo gpasswd -a ${USER} docker
sudo service docker restart

# install unicreds
cd /home/vagrant
wget https://github.com/Versent/unicreds/releases/download/v1.5.0/unicreds_1.5.0_linux_x86_64.tgz
tar xzvf unicreds_1.5.0_linux_x86_64.tgz
chmod +x unicreds
sudo mv unicreds /usr/local/bin/

# install nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.1/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# install node
nvm i 6

# install awscli
sudo pip install awscli

# setup shared network
sudo docker network create u235

# cd to /vagrant by default
echo "cd /vagrant" >> /home/vagrant/.bashrc

# copy docker utility scripts
sudo cp /vagrant/scripts/reactor-dev.sh /usr/local/bin/u235dev
sudo cp /vagrant/scripts/reactor-run.sh /usr/local/bin/u235run
sudo chmod +x /usr/local/bin/u235dev
sudo chmod +x /usr/local/bin/u235run

