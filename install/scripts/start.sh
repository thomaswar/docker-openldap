#!/usr/bin/env bash

exec slapd -4 -h "ldap://0.0.0.0:$SLAPDPORT/" \
    -d conns,config,stats,shell,trace \
    -f /etc/openldap/slapd.conf
