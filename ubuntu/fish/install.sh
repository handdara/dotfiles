#!/bin/sh

export DEBIAN_FRONTEND=noninteractive
sudo apt-add-repository -y ppa:fish-shell/release-3
sudo apt-get -y update
sudo apt-get -y install fish
unset DEBIAN_FRONTEND

# got a problem when running above: 
# `E: dpkg was interrupted, you must manually run 'sudo dpkg --configure -a' to correct the problem.`
