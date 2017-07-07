pipeline {
    agent any

    stages {
        stage('Git pull + branch + submodule') {
            steps {
                sh '''
                echo 'hard coding git branch - TODO: move this to the jenkins git plugin'
                git checkout master
                echo 'pulling updates'
                git pull
                git submodule update --init
                cd ./dscripts && git checkout master && git pull && cd ..
                '''
            }
        }
        stage('docker cleanup') {
            steps {
                sh './dscripts/manage.sh rm 2>/dev/null || true'
                sh './dscripts/manage.sh rmvol 2>/dev/null || true'
                sh 'sudo docker ps --all'
            }
        }
        stage('Build') {
            steps {
                sh '''
                echo 'Building..'
                rm conf.sh 2> /dev/null || true
                ln -s conf.sh.default conf.sh
                ./dscripts/build.sh
                '''
            }
        }
        stage('Test ') {
            steps {
                sh '''
                echo 'Configure & start slapd ..'
                ./dscripts/run.sh -IpV /tests/init_sample_config_phoAt.sh
                ./dscripts/run.sh -pV  # start slapd in background
                sleep 2
                '''
                sh '''
                echo 'Load test data ..'
                ./dscripts/exec.sh -I /tests/init_sample_data_phoAt.sh
                '''
                sh '''
                echo 'query data ..'
                ./dscripts/exec.sh -I /tests/dump_testuser.sh
                ./dscripts/exec.sh -I /tests/authn_testuser.sh
                ./dscripts/exec.sh -I python3.4 /tests/test1.py
                '''
            }
        }
    }
    post {
        always {
            echo 'removing docker container and volumes'
            sh '''
            ./dscripts/manage.sh rm 2>&1 || true
            ./dscripts/manage.sh rmvol 2>&1
            '''
        }
    }
}
