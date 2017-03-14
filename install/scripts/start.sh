#!/usr/bin/env bash

exec slapd -4 -h "ldap://$SLAPDHOST:$SLAPDPORT/" \
    -d conns,config,stats,shell,trace \
    -f /etc/openldap/slapd.conf
