FROM rhel
MAINTAINER kdevensen@gmail.com

ENV container=oci
RUN yum install -y --setopt=tsflags=nodocs --disablerepo='*' --enablerepo='rhel-7-server-rpms' --enablerepo='rhel-7-server-ose-3.7-rpms'\
		make \
    		nmap-ncat \
    		npm \
    		gcc-c++ \
		git \
                atomic-openshift-clients \
		java-1.8.0-openjdk-devel && \
    yum clean all && \
    rm -rf /var/cache/yum/*
RUN useradd wettyuser -u 1001
RUN npm install wetty -g chdir=/home/wetty
RUN openssl req -new \
      		-x509 \
      		-nodes \
      		-days 3650 \
      		-subj "/C=US/ST=NC/L=RALEIGH/O=RED HAT/OU=NAPS/CN=wetty.apps.kenscloud.io/emailAddress=kevensen@redhat.com" \
      		-newkey rsa:2048 \
      		-keyout /home/wettyuser/.ssh/privkey.pem \
      		-out /home/wettyuser/.ssh/cert.pem && \
    chmod 0400 /home/wettyuser/.ssh/*.pem && \
    chown 1001:1001 /home/wettyuser/.ssh/*.pem

USER 1001
ENTRYPOINT ['/usr/lib/node_modules/wetty/bin/wetty.js', '--sslkey /home/wettyuser/.ssh/privkey.pem', '--sslcert /home/wettyuser/.ssh/cert.pem', '-p 8888']
