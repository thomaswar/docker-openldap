#!/bin/sh

tar -cjf compare-openldap-overlay.tar.bz2 compare-openldap-overlay

mkdir -p install/build

mv compare-openldap-overlay.tar.bz2 install/build
