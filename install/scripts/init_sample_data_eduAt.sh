#!/bin/sh

echo "loading openldap with sample data"

ldapadd -h localhost -p $SLAPDPORT \
    -x -D cn=admin,dc=at -w $ROOTPW \
    -c -f /opt/sample_data/etc/openldap/data/eduAt_init.ldif

ldappasswd -h localhost -p $SLAPDPORT \
    -x -D cn=admin,dc=at -w $ROOTPW \
    -s 'test' 'uid=test.user1234567, dc=schule, dc=at'

# to undo:
# ldapdelete -h localhost -p $SLAPDPORT -x -D cn=admin,dc=at -w $ROOTPW 'uid=test.user1234567,dc=schule,dc=at'


