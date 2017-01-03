FROM  centos:centos7
MAINTAINER Rainer Hörbe r2h2@hoerbe.at

RUN yum -y install curl iproute lsof net-tools \
 && yum -y install openldap openldap-servers openldap-clients \
 && yum clean all

# save system default ldap config and extend it with project-specific files
RUN mkdir -p /opt/sample_data/etc/openldap/conf/schema/ \
 && mkdir -p /opt/sample_data/etc/openldap/data/ \
 && cp -pr /etc/openldap/* /opt/sample_data/etc/openldap/conf/
COPY install/conf/*.conf /opt/sample_data/etc/openldap/conf/
COPY install/conf/schema/* /opt/sample_data/etc/openldap/conf/schema/
COPY install/data/* /opt/sample_data/etc/openldap/data/

RUN cp -p /usr/share/openldap-servers/DB_CONFIG.example /var/lib/ldap/DB_CONFIG

COPY install/scripts/* /
RUN chmod +x /*.sh
VOLUME /etc/openldap/
VOLUME /var/log/
USER ldap
CMD /start.sh
