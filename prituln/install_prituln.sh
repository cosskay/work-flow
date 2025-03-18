#!/bin/bash

# from `host azure.archive.ubuntu.com`
echo -e '\n20.189.76.178 archive.ubuntu.com\n' | sudo tee -a /etc/hosts

sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list << EOF
deb https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.2 multiverse
EOF

sudo tee /etc/apt/sources.list.d/pritunl.list << EOF
deb https://repo.pritunl.com/stable/apt bionic main
EOF

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv E162F504A20CDF15827F718D4B7C549A058F8B6B
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7568D9BB55FF9E5287D586017AE645C0CF8E292A
sudo apt-get update && sudo apt-get --assume-yes install pritunl mongodb-org wireguard

# set mongo with login
sudo systemctl start mongod
export MONGO_PASSWORD=$(< /dev/urandom tr -dc _A-Za-z0-9 | head -c${1:-32})
echo -e 'use admin; \ndb.createUser({user: "admin", pwd: "'$MONGO_PASSWORD'", roles: [ "userAdminAnyDatabase", "dbAdminAnyDatabase", "readWriteAnyDatabase"]});' | tee | mongo
echo -e '\nsecurity:\n  authorization: enabled\n' | sudo tee -a /etc/mongod.conf
sudo systemctl restart mongod

# config mongo with password at pritunl
sudo pritunl set-mongodb "mongodb://admin:$MONGO_PASSWORD@localhost:27017/pritunl?authSource=admin"

sudo systemctl start pritunl
sudo systemctl enable pritunl mongod

sudo pritunl default-password
## get default password to login web panel
