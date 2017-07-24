#!/bin/sh

echo "loading openldap with sample edu data"

rootdn=$(grep ^rootdn /etc/openldap/slapd.conf | awk {'print $2'} | tr -d '"')

ldapadd -h localhost -p $SLAPDPORT \
    -x -D $rootdn -w $ROOTPW \
    -c -f /opt/sample_data/etc/openldap/data/edushareAt_init.ldif

ldappasswd -h localhost -p $SLAPDPORT \
    -x -D $rootdn -w $ROOTPW \
    -s 'test' 'uid=test.user1234567, dc=schule, dc=at'

ldappasswd -h localhost -p $SLAPDPORT \
    -x -D $rootdn -w $ROOTPW \
    -s 'test' 'uid=test.user2_adam, dc=schule, dc=at'

ldappasswd -h localhost -p $SLAPDPORT \
    -x -D $rootdn -w $ROOTPW \
    -s 'test' 'uid=test.user3_eva, dc=schule, dc=at'

ldappasswd -h localhost -p $SLAPDPORT \
    -x -D $rootdn -w $ROOTPW \
    -s 'test' 'uid=test.user4_berta, dc=schule, dc=at'

# to undo (per DN)
# ldapdelete -h localhost -p $SLAPDPORT -x -D $rootdn -w $ROOTPW 'uid=test.user1234567,dc=schule,dc=at'


