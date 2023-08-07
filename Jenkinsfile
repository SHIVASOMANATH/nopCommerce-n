pipeline {
    agent { label 'DOTNET_7' }
    options {
        timeout(time: 1, unit: 'HOURS')
    }
    triggers {
        pollSCM('* * * * *')
    }
    tools {
        jdk 'JDK_17'
    }
    stages {
        stage ('VCS') {
            steps {
                git url: 'https://github.com/SHIVASOMANATH/nopCommerce-n.git',
                    branch: 'develop'
            }
        }       
        stage ('Build') {
            steps {
                sh 'cd /home/jenkins/workspace/NopCommercedocker'
                sh 'docker image build -t shivasomanath/nop:2.0 .'
                sh 'docker image push shivasomanath/nop:2.0' 
            }
        } 
    }
}
