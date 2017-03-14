#!/usr/bin/env bash

# add SLAPDHOST to /etc/hosts
[ -z $SLAPDHOST ] && echo 'SLAPDHOST not set' && exit 1
sed -e "s/$HOSTNAME\$/$HOSTNAME $SLAPDHOST/" /etc/hosts

exec slapd -4 -h "ldap://$SLAPDHOST:$SLAPDPORT/" \
    -d conns,config,stats,shell,trace \
    -f /etc/openldap/slapd.conf
