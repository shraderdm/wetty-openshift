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
RUN useradd wetty -u 1001 && \ 
    echo "wetty" | passwd wetty --stdin && \
    mkdir -p /opt/wetty/.pki && \
    chown -R 1001:1001 /opt/wetty


RUN npm install wetty
RUN openssl req -new \
      		-x509 \
      		-nodes \
      		-days 3650 \
      		-subj "/C=US/ST=NC/L=RALEIGH/O=RED HAT/OU=NAPS/CN=wetty.apps.kenscloud.io/emailAddress=kevensen@redhat.com" \
      		-newkey rsa:2048 \
      		-keyout /opt/wetty/.pki/privkey.pem \
      		-out /opt/wetty/.pki/cert.pem && \
    chmod 0400 /opt/wetty/.pki/*.pem && \
    chown 1001:1001 /opt/wetty/.pki/*.pem

USER 1001
ENTRYPOINT ['/usr/lib/node_modules/wetty/bin/wetty.js', '--sslkey /opt/wetty/.pki/privkey.pem', '--sslcert /opt/wetty/.pki/cert.pem', '-p 8888']
