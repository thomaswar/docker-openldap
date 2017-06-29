#!/bin/sh
# This script sets up the phoAtRepl replication example with Image IDs 06 and 07
#
# Usage:
# Check out the repo as docker-openldap
# Start the script in the directory that holds the docker-openldap
#
# Notes:
# The script will generate two new directories XX_docker-openldap from this
#
# The machine names XX_openldap are referenced in the config files. If you change
# the IDs here, you have to change the corresponding entries in the config files


main () {
	IID=06
	build
	feed

	IID=42
	build

	IID=43
	build
}

build(){
	rm -rf ${IID}_docker-openldap
	cp -a docker-openldap ${IID}_docker-openldap
	cd ${IID}_docker-openldap
	cat conf.sh.repl | \
		sed s/set_image_signature_args$/#set_image_signature_args/ | \
		sed s/"IMGID='06'"/"IMGID='${IID}'"/ | \
		cat > conf.sh

	git submodule update --init
	cd dscripts && git checkout master && cd ..
	dscripts/build.sh

	dscripts/run.sh -ir /tests/init_sample_config_phoAtRepl.sh
	dscripts/run.sh -p
	cd ..
}

feed(){
	cd ${IID}_docker-openldap
	dscripts/exec.sh  /tests/init_sample_data_phoAt.sh
	cd ..
}

main
