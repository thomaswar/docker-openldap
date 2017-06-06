#!/usr/bin/env bash

ldapsearch -h localhost -p $SLAPDPORT -x -D cn=admin,dc=at -w $ROOTPW -b dc=at -L 'cn=*'

# ldapsearch -h localhost -p $SLAPDPORT -x -D cn=admin,dc=at -w $ROOTPW -b dc=at -L 'uid=test.user1234567'
# ldapmodify -h localhost -p $SLAPDPORT -x -D cn=admin,dc=at -w $ROOTPW -c -f /tmp/x.ldif
# ldapdelete -h localhost -p $SLAPDPORT -x -D cn=admin,dc=at -w $ROOTPW uid=test.user2_adam,dc=schule,dc=at
