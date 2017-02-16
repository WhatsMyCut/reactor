#!/bin/bash -e
cd /vagrant
mkdir -p repos
cd repos

ssh-keyscan -t rsa github.com >> /home/vagrant/.ssh/known_hosts

# list of u235 repos
repos=(
  'u235core'
  'u235ctrl'
#  'u235logger'
)

# iterate through repo list and clone if the directory doesn't exist
count=0
while [ "x${repos[count]}" != "x" ]
do
  if [ ! -d ${repos[count]} ]; then
    git clone git@github.com:whatsmycut/${repos[count]}.git
  fi
  count=$(( $count + 1 ))
done
