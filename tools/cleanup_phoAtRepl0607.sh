#!/bin/sh
docker ps | grep "openldap$" | cut -f 1 -d " " | xargs docker rm -f
docker volume ls | grep openldap | sed s/" \+"/"\t"/ | cut -f2 | xargs -n 1 -t docker volume rm 

