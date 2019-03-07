#!/bin/bash
# tells what kind of shell script to use for this environment

sudo apt-get update -y
# gets latest version of ubuntu package list

sudo apt-get upgrade -y
# upgrades package list to lastest version it has available

sudo apt-get install nginx -y
# installs nginx


sudo apt-get install python-software-properties

#
curl -sL https://deb.nodesource.com/setup_6.x | sudo bash -

# installs nodejs
sudo apt-get install nodejs -y

sudo npm install pm2 -g
