#!/bin/sh

echo "loading /etc/openldap with sample data "

ldapadd -h $SLAPDHOST -p $SLAPDPORT \
    -x -D cn=admin,dc=at -w $ROOTPW \
    -c -f /opt/sample_data/etc/openldap/data/phoAt_init.ldif

ldappasswd -h $SLAPDHOST -p $SLAPDPORT \
    -x -D cn=admin,dc=at -w $ROOTPW \
    -s 'test' \
    'cn=test.user1234567, o=ph-noe, dc=ac, dc=at'
