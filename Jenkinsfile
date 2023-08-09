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
        stage('deploy') {
            steps {
                sh 'cd /home/jenkins/workspace/FleaCommerce/Terraform && terraform init && terraform fmt && terraform apply -auto-approve ' 
                sh 'echo "$(terraform output kube_config)" > ./azurek8s && export KUBECONFIG=./azurek8s && kubectl apply -f ../k8s/NopDeploy.yaml'
                // sh '&& kubectl apply -f ./home/jenkins/workspace/FleaCommerce/K8S/NopDeploy.yaml'
            }
        }    
    }
}
