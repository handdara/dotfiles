#!/bin/sh

# possibly need to add Uinput group/permisions
sudo groupadd uinput
sudo usermod -aG input handdara
sudo usermod -aG uinput handdara

# udev rules for uinput
echo 'attempting to place rules file'
sudo cp ./99-uinput-kmonad.rules /etc/udev/rules.d/99-uinput-kmonad.rules 
