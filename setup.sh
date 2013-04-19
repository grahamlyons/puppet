#!/bin/sh

set -e

apt-get update &&\
apt-get install puppet git -y &&\
git clone https://github.com/grahamlyons/puppet /var/puppet &&\
cd /var/puppet/ &&\
git submodule update --init &&\
puppet apply --modulepath=./modules manifests/site.pp
