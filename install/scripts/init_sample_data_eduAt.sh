#!/bin/sh

echo "loading openldap with sample data"

ldapadd -h localhost -p $SLAPDPORT \
    -x -D cn=admin,dc=at -w $ROOTPW \
    -f /opt/sample_data/etc/openldap/data/eduAt_init.ldif

ldappasswd -h localhost -p $SLAPDPORT \
    -x -D cn=admin,dc=at -w $ROOTPW \
    -s 'test' -c \
    'uid=tester@testinetics.at, dc=edu, dc=at'

