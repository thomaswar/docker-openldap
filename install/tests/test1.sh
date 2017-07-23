#!/usr/bin/env bash

rootdn=$(grep ^rootdn /etc/openldap/slapd.conf | awk {'print $2'})
suffix=$(grep ^suffix /etc/openldap/slapd.conf | awk {'print $2'})

python3 /tests/test1.py -D $rootdn -b $suffix
