FROM larsks/runit:fedora20
MAINTAINER Lars Kellogg-Stedman <lars@oddbit.com>

RUN yum -y install \
	python-pbr \
	git \
	python-devel \
	python-setuptools \
	python-pip \
	gcc \
	libxml2-python \
	libxslt-python \
	python-lxml \
	sqlite \
	python-repoze-lru  \
	crudini \
	yum-utils

# This pulls in all the dependencies of the python-heat package
# without actually installing python-heat (because we're going to install
# that from source).
RUN yum -y install $(repoquery --requires openstack-heat-common | awk '{print $1}')
RUN useradd -r -d /srv/heat -m heat

# Download and install heat from source.
WORKDIR /opt
RUN git clone http://github.com/openstack/heat.git
WORKDIR /opt/heat
RUN python setup.py install

# install runit services
ADD heat.sysinit /etc/runit/sysinit/heat
ADD service /service

VOLUME /srv/heat
EXPOSE 8000 8004

ADD install-config.sh /opt/heat/install-config.sh
RUN sh /opt/heat/install-config.sh

ADD configure-heat.sh /opt/heat/configure-heat.sh
RUN sh /opt/heat/configure-heat.sh

