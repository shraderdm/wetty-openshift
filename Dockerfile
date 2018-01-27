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
RUN useradd default -u 1001
