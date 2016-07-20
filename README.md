# OpenLDAP docker image  

Specific features of this project:

1. Execute slapd as non-root user
2. A user-defined network uses static IP addresses. 
3. Image is based on centos7     

The image produces immutable containers, i.e. a container can be removed and re-created
any time without loss of data, because data is stored on mounted volumes.

## Configuration

1. Clone this repository
2. Copy conf.sh.default to confXX.sh, where XX is a unique container number on the docker host
3. Run `git submodule init` and `git submodule update`
4. Modify confXX.sh

## Usage

    cd <project root>
    dscript/build.sh
    dscript/run.sh [-p] # start slapd in daemon mode
    dscript/run.sh -ir /scripts/init_sample_config.sh    # initialize sample configuration, set root-pw
    dscript/exec.sh /scripts/init_sample_data_xxxx.sh    # initialize sample data, see install/scripts/
    dscript/run.sh -ir  # start interactive bash as root user  
    dscript/exec.sh -i  # open a second shell
