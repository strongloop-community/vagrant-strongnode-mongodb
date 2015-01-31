#!/usr/bin/env bash

# root su yourself
sudo su

export DEBIAN_FRONTEND=noninteractive

# way of checking if you we need to install everything
if [ ! -e "/var/strongnode-app-folder" ]; then
    # Add mongo to apt
    apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10 &> /dev/null
    echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' \
		> /etc/apt/sources.list.d/mongodb.list

    # Update and begin installing some utilities and the latest stable of mongo
	echo "Updating apt..."
    apt-get update > /dev/null

	echo "Installing dev tools.."
    apt-get install -y vim git curl build-essential &> /dev/null

	echo "Installing mongodb..."
	apt-get install -y mongodb-org &> /dev/null

	# Install Node
	echo "Installing node..."
	mkdir -p /usr/local/src/node /usr/local/etc
	curl -s http://nodejs.org/dist/v0.10.36/node-v0.10.36-linux-x64.tar.gz \
		| tar -xz -C /usr/local --strip-components 1 -f -
	curl -s http://nodejs.org/dist/v0.10.36/node-v0.10.36.tar.gz \
		| tar -xz -C /usr/local/src/node --strip-components 1 -f -
	echo "nodedir = /usr/local/src/node" > /usr/local/etc/npmrc

	# Install StrongLoop
	echo "Installing strongloop..."
	npm install -g strongloop > /dev/null
	echo "done."

	# Symlink our host node-apps to the guest /var/node-apps folder
	ln -s /vagrant/strongnode-app-folder /var/strongnode-app-folder

	echo "You can place other node apps in gthe /strongnode-app-folder/ and find them at /var/strongnode-app-folder/"
	echo " 'slc run /var/strongnode-app-folder/myApp/app.js' to run the strong node node app in strongnode-app-folder/myApp"
fi
