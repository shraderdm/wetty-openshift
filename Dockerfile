FROM rhel
MAINTAINER kdevensen@gmail.com
ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk
ENV PATH="${PATH}:/usr/bin/apache-maven-3.5.2/bin/"
RUN yum install -y --setopt=tsflags=nodocs --disablerepo='*' --enablerepo='rhel-7-server-rpms' --enablerepo='rhel-7-server-ose-3.7-rpms'\
		make \
    		nmap-ncat \
    		npm \
    		gcc-c++ \
		git \
                atomic-openshift-clients \
		openssl \
		unzip \
		java-1.8.0-openjdk-devel \
                openssh-server && \
    yum clean all && \
    rm -rf /var/cache/yum/*
ADD http://download.nextag.com/apache/maven/maven-3/3.5.2/binaries/apache-maven-3.5.2-bin.zip /root/
RUN chmod a+rx /opt/start.sh
RUN cd /root && \
    unzip /root/apache-maven-3.5.2-bin.zip && \
    mv apache-maven-3.5.2 /usr/bin/

ADD start.sh /opt/start.sh
RUN npm install https://github.com/krishnasrinivas/wetty.git -g
RUN useradd default -u 1001 -g 0

EXPOSE 8080

USER 1001
ENTRYPOINT ["/opt/start.sh"]
