pipeline {
    agent { label 'DOTNET_7' }
    options {
        timeout(time: 1, unit: 'HOURS')
    }
    triggers {
        pollSCM('* * * * *')
    }
    // tools {
    //     jdk 'JDK_17'
    // }
    stages {
        stage ('VCS') {
            steps {
                git url: 'https://github.com/SHIVASOMANATH/nopCommerce-n.git',
                    branch: 'develop'
            }
        }
        stage ('Build') {
            steps {    
                sh 'dotnet build -c Release src/NopCommerce.sln'
                sh 'dotnet publish -c Release src/Presentation/Nop.Web/Nop.Web.csproj -o "./published"'
            }
            post {
                success {
                    sh 'mkdir ./published/bin ./published/logs'
                    sh 'tar -czvf nop.web.tar.gz ./published/'
                    archiveArtifacts '**/*.tar.gz'
                }
            }
        stage ('Build2') {
            steps {
                sh 'cd /home/jenkins/workspace/FleaCommerce'
                sh 'docker image build -t shivasomanath/nop:3.0 .'
                sh 'docker image push shivasomanath/nop:3.0' 
            }
        }
        stage('deploy') {
            steps {
                sh 'cd /home/jenkins/workspace/FleaCommerce/Terraform && terraform init && terraform fmt && terraform apply -auto-approve && terraform output kube_config' 
                //sh 'terraform output kube_config'
                sh 'cd /home/jenkins/workspace/FleaCommerce/Terraform && terraform output kube_config > ./azurek8s && ls -al && export KUBECONFIG=./azurek8s '
                sh 'export KUBECONFIG=./azurek8s && kubectl apply -f /home/jenkins/workspace/FleaCommerce/K8S/NopDeploy.yaml'
                // sh '&& kubectl apply -f ./home/jenkins/workspace/FleaCommerce/K8S/NopDeploy.yaml'
            }
        }    
    }
}
