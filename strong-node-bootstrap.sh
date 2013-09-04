#!/usr/bin/env bash

# root su yourself
sudo su

# way of checking if you we need to install everything
if [ ! -d "/var/strongnode-app-folder" ]
then
    # Add mongo to apt
    apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
    echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/10gen.list
		
    # Update and begin installing some utility tools
    apt-get -y update
    apt-get install -y python-software-properties
    apt-get install -y vim git subversion curl
    apt-get install -y memcached build-essential
		
		#install git
		apt-get --yes --force-yes install git
		
		# Install latest stable version of mongo
		if [ ! -d "/var/strongnode-app-folder" ]
		then
			mkdir /data
			mkdir /data/db/
			echo " running: apt-get install mongodb-10gen "
    	apt-get install -y mongodb-10gen
			#apt-get install -y mongodb-server
		fi
		
		# Install StrongLoop Node
		cd /opt
			# strongloop-node_1.1.4-1_amd64.deb
		# sudo wget http://strongloop.com/products/downloads/5334/u-0075
		sudo wget -O strongloop-node_amd64.deb http://strongloop.com/products/downloads/5334/u-0075
		sudo dpkg -i strongloop-node_amd64.deb
		
		#install some npm components
		sudo npm install -g forever
		
		# Symlink our host node-apps to the guest /var/node-apps folder
    ln -s /vagrant/strongnode-app-folder /var/strongnode-app-folder
		
    echo "You can place other node apps in gthe /strongnode-app-folder/ and find them at /var/strongnode-app-folder/"
    echo " 'slc run /var/strongnode-app-folder/myApp/app.js' to run the strong node node app in strongnode-app-folder/myApp"
		
    # Run the /var/strongnode-app-folder with slc run app.js

		# Run the mongodb server
		mongod
fi