#!/bin/sh

crudini --set /etc/heat/heat.conf \
	DEFAULT \
	debug \
	false
crudini --set /etc/heat/heat.conf \
	DEFAULT \
	verbose \
	true
crudini --set /etc/heat/heat.conf \
	DEFAULT \
	rpc_backend \
	heat.openstack.common.rpc.impl_kombu
crudini --set /etc/heat/heat.conf \
	DEFAULT \
	rabbit_host \
	rabbitmq

##
## Authentication
##
crudini --set /etc/heat/heat.conf \
	keystone_authtoken \
	auth_uri \
	http://keystone:35357/v2.0
crudini --set /etc/heat/heat.conf \
	keystone_authtoken \
	admin_tenant_name \
	services
crudini --set /etc/heat/heat.conf \
	keystone_authtoken \
	admin_user \
	heat
crudini --set /etc/heat/heat.conf \
	keystone_authtoken \
	admin_password \
	heat
crudini --del /etc/heat/heat.conf \
	keystone_authtoken \
	auth_host
crudini --del /etc/heat/heat.conf \
	keystone_authtoken \
	auth_port
crudini --del /etc/heat/heat.conf \
	keystone_authtoken \
	auth_protocol

