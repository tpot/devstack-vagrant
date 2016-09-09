#!/bin/sh -xe
#
# Install and provision devstack inside a Vagrant machine
#
# Warming of apt and pip cache idea taken from nand2:
# https://github.com/nand2/vagrant-devstack/blob/master/devstack-bootstrap.sh
#

# Warm up apt and pip cache
sudo rsync -a /vagrant/apt_cache/ /var/cache/apt
sudo mkdir -p /root/.cache
sudo rsync -a /vagrant/pip_cache/ /root/.cache/pip

# Install git
sudo apt-get update
sudo apt-get install -y git

# Checkout devstack
[ -d devstack ] || git clone -b stable/mitaka git://192.168.1.39/openstack-dev/devstack

# Copy config and run devstack
cp /vagrant/localrc devstack
(cd devstack ; ./stack.sh)

# Install well-known insecure public key
mkdir -p ~/.ssh
cp vagrant_insecure.pub ~/.ssh/authorized_keys

# Copy back apt and pip cache data
sudo rsync -a /var/cache/apt/ /vagrant/apt_cache
sudo rsync -a /root/.cache/pip/ /vagrant/pip_cache
