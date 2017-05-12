#!/bin/sh
# initialize slapd.conf

mv /etc/openldap/slapd.conf /etc/openldap/slapd.conf.default
mv /etc/openldap/slapd_edu_at_example.conf /etc/openldap/slapd.conf

if [ $(grep -q '^rootpw' /etc/openldap/slapd.conf) ]; then
    echo "rootpw directive already set in slapd.conf"
else
    slappasswd -s $ROOTPW > /tmp/rootpw
    echo "rootpw $(cat /tmp/rootpw)" >> /etc/openldap/slapd.conf
    rm -f /tmp/rootpw
    echo "rootpw directive added to slapd.conf"
fi

