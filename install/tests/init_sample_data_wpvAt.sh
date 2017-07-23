#!/bin/sh

echo "loading /etc/openldap with sample data"

rootdn=$(grep ^rootdn /etc/openldap/slapd.conf | awk {'print $1'})

ldapadd -h localhost -p $SLAPDPORT \
    -x -D $rootdn -w $ROOTPW \
    -c -f /opt/sample_data/etc/openldap/data/wpvAt_init.ldif

ldappasswd -h localhost -p $SLAPDPORT \
    -x -D $rootdn -w $ROOTPW \
    -s 'test' \
    'uid=tester@testinetics.at, gln=9110017333914, dc=wpv, dc=at'

