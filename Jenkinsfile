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
        stage ('Build and Package') {
             steps {
                 sh script: '''dotnet restore src/NopCommerce.sln \n
                             dotnet build -c Release src/NopCommerce.sln \n
                             dotnet publish -c Release src/Presentation/Nop.Web.csproj -o publish '''
            }     
        }
        stage ('Creating folders') {
             steps {
                sh script: 'mkdir publish/bin publish/logs',
                           'zip -r nopCommerce.zip publish'
                     }
        }
    }
} 