#!/bin/sh
# container entrypoint for initializing mounted volumes with test data

echo "initializing /etc/openldap with sample configuration"
cp -pr --interactive /opt/sample_data/etc/openldap/conf/* /etc/openldap/

if [ $(grep -q '^rootpw' /etc/openldap/slapd.conf) ]; then
    echo "rootpw directive already set in slapd.conf"
else
    slappasswd -s $ROOTPW > /tmp/rootpw
    echo "rootpw $(cat /tmp/rootpw)" >> /etc/openldap/slapd.conf
    rm -f /tmp/rootpw
    echo "rootpw directive added to slapd.conf"
fi

echo "next step for you: now start slapd and load initial data"