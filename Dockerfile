FROM registry.access.redhat.com/rhscl/nodejs-4-rhel7:latest
MAINTAINER kdevensen@gmail.com
USER root
RUN yum install -y --setopt=tsflags=nodocs --disablerepo='*' --enablerepo='rhel-7-server-rpms' --enablerepo='rhel-7-server-ose-3.7-rpms'\
		make \
    		nmap-ncat \
    		npm \
    		gcc-c++ \
		git \
                atomic-openshift-clients \
		openssl \
		java-1.8.0-openjdk-devel && \
    yum clean all && \
    rm -rf /var/cache/yum/*
RUN usermod default -s /bin/bash
EXPOSE 3000
EXPOSE 22

USER 1001
