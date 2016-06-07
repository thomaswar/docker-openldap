#!/usr/bin/env bash

# start command added by docker build to get username right
slapd -4 -h "ldap://0.0.0.0:$SLAPDPORT/" \
    -d conns,config,stats,shell,trace \
    -f /etc/openldap/slapd.conf \
    -g $USERNAME -u $USERNAME

# keep the container running even if slapd terminates
sleep infinity
