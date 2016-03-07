#!/usr/bin/env bash

# configure container
export IMGID='6'  # range from 2 .. 99; must be unique
export IMAGENAME="r2h2/openldap${IMGID}"
export CONTAINERNAME="${IMGID}openldap"
export CONTAINERUSER="slapd${IMGID}"   # group and user to run container
export CONTAINERUID="800${IMGID}"   # gid and uid for CONTAINERUSER
export SLAPDPORT=8389
export BUILDARGS="
    --build-arg SLAPDPORT=$SLAPDPORT \
    --build-arg USERNAME=$CONTAINERUSER \
    --build-arg UID=$CONTAINERUID \
"
export ENVSETTINGS="
    -e SLAPDPORT=$SLAPDPORT
    -e ROOTPW=changeit
    -e USERNAME=$CONTAINERUSER
"
export NETWORKSETTINGS="
    --log-driver=syslog --log-opt syslog-facility=daemon --log-opt syslog-tag=slapd
    --net http_proxy
    --ip 10.1.1.${IMGID}
"
export VOLROOT="/docker_volumes/$CONTAINERNAME"  # container volumes on docker host
export VOLMAPPING="
    -v $VOLROOT/etc/openldap/:/etc/openldap/:Z
    -v $VOLROOT/var/db:/var/db/:Z
    -v $VOLROOT/var/log/:/var/log/:Z
"
export STARTCMD='/scripts/start.sh'

# first create user/group/host directories if not existing
if ! id -u $CONTAINERUSER &>/dev/null; then
    groupadd -g $CONTAINERUID $CONTAINERUSER
    adduser -M -g $CONTAINERUID -u $CONTAINERUID $CONTAINERUSER
fi
if [ -d $VOLROOT/var/log/$CONTAINERNAME ]; then
    mkdir -p $VOLROOT/var/log
    chown $CONTAINERUSER:$CONTAINERUSER $VOLROOT/var/log
fi
# create dir with given user if not existing, relative to $HOSTVOLROOT; set/repair ownership
function chkdir {
    dir=$1
    user=$2
    mkdir -p "$VOLROOT/$dir"
    chown -R $user:$user "$VOLROOT/$dir"
}
chkdir etc/openldap $CONTAINERUSER
chkdir var/db $CONTAINERUSER
chkdir var/log $CONTAINERUSER
