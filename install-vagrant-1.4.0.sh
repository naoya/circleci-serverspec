#!/bin/sh

set -x
set -e

if [ ! -e vagrant ]; then
  git clone git@github.com:mitchellh/vagrant.git
fi

cd vagrant
git checkout refs/tags/v1.4.0
bundle install
rake install

if [ ! -e ~/.vagrant.d ]; then
  vagrant plugin install vagrant-aws
  vagrant box add dummy https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box
fi
