#!/bin/sh

# Install the sample configuration files.
mkdir -p /etc/heat
cd /opt/heat
cp -r etc/heat/* /etc/heat/
mv /etc/heat/heat.conf.sample /etc/heat/heat.conf

