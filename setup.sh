#!/bin/sh

set -e

aptitude update &&\
aptitude install puppet git -y &&\
git clone https://github.com/grahamlyons/puppet /var/puppet &&\
cd /var/puppet/ &&\
git submodule update --init &&\
puppet apply --modulepath=./modules manifests/site.pp
