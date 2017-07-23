#!/usr/bin/env bash


slapd -4 -h ldap://$SLAPDHOST:$SLAPDPORT/ -d $DEBUGLEVEL -f /etc/openldap/slapd.conf
