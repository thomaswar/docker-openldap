# OpenLDAP docker image  

Specific features of this project:
1. slapd runs as non-root user
2. The user-defined network uses static IP addresses. 
3. Image is based on centos7     

The image produces immutable containers, i.e. a container can be removed and re-created
any time without loss of data, because data is stored on mounted volumes.

# Build the docker image
1. adapt conf.sh
2. run build.sh


## Usage:
    cd <project root>
    ./run.sh -h  # print usage
    ./run.sh -ir /scripts/init_sample_config.sh    # initialize sample configuration, set root-pw
    ./run.sh     # start container with slapd  
    ./exec.sh /scripts/init_sample_data_wpvAt.sh    # initialize sample data
    
    exec.sh -ipr bash  # interavtive, print run command, root user 
    