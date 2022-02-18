#!/bin/bash

# Just for formatting messages
redBold="\x1B[1;41;97m"
greenBold="\x1B[1;42;97m"
resetStyle="\x1B[0m "

# Update these variables!!
auth_token=${TOKEN}
elastic_ip_cidr=${GLOBAL_CIDR}
elastic_ip=${GLOBAL_IP}
netmask=255.255.255.254

# Contact Metal Metadata Service to get instances information.
printf "Making GET request to Metadata API to learn more about this server."
json=$(curl https://metadata.platformequinix.com/metadata)
instance_id=$(echo $json | jq -r ".id")

# Configure the local network, this assumes we're working on Ubuntu 20.04, network configuration will typically vary by distro.
printf "Configuring the local network by creating a lo:0 interface with our Global Elastic IP"

cat >> /etc/network/interfaces <<- EOF
auto lo:0
  iface lo:0 inet static
  address $elastic_ip
  netmask $netmask
EOF

ifup lo:0

export DEBIAN_FRONTEND=noninteractive
apt-get update && apt-get upgrade -y
apt-get install nginx -y
ufw allow 'Nginx HTTP'
ufw enable
sed -i 's/Thank you for using nginx./Europe/g' /var/www/html/index.nginx-debian.html
