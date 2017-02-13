#!/usr/bin/env bash

ldapsearch -h localhost -p $SLAPDPORT -x -D uid=tester@testinetics.at,gln=9110017333914,dc=wpv,dc=at \
    -w test -b dc=at -L 'uid=tester@testinetics.at'

ldapsearch -h localhost -p $SLAPDPORT -x -D uid=test.user1234567, dc=schule, dc=at \
    -w test -b dc=at -L 'uid=test.user1234567'


