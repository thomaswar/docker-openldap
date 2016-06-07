FROM  centos:centos7
MAINTAINER Rainer Hörbe r2h2@hoerbe.at

RUN yum -y install curl iproute lsof net-tools

# need to map ldap uid to docker host - prevent creation by rpm install; later change it to $USERNAME
ENV USERNAME_DEFAULT ldap
ARG UID
RUN groupadd --gid $UID $USERNAME_DEFAULT \
 && useradd --gid $UID --uid $UID $USERNAME_DEFAULT \
 && chown $USERNAME_DEFAULT:$USERNAME_DEFAULT /run

RUN yum -y install openldap openldap-servers openldap-clients

# save system default ldap config and extend it with project-specific files
RUN mkdir -p /opt/sample_data/etc/openldap/conf/schema/ \
 && mkdir -p /opt/sample_data/etc/openldap/data/ \
 && cp -pr /etc/openldap/* /opt/sample_data/etc/openldap/conf/
COPY install/conf/*.conf /opt/sample_data/etc/openldap/conf/
COPY install/conf/schema/* /opt/sample_data/etc/openldap/conf/schema/
COPY install/data/* /opt/sample_data/etc/openldap/data/

ARG USERNAME
RUN usermod -l $USERNAME $USERNAME_DEFAULT \
 && groupmod -n $USERNAME $USERNAME_DEFAULT
 #&& chown -R $USERNAME:$USERNAME /opt/sample_data/etc/openldap/slapd.* \
 #&& chmod -R 750 /opt/sample_data/etc/openldap/slapd.*

RUN cp /usr/share/openldap-servers/DB_CONFIG.example /var/lib/ldap/DB_CONFIG
# RUN chown $USERNAME:$USERNAME /var/lib/ldap/DB_CONFIG

# set config for client (for test purposes) : BASE, URL

ARG SLAPDPORT
COPY install/scripts/* /
RUN chmod +x /*.sh
CMD /start.sh
