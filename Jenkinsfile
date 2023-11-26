pipeline {
    agent any

    tools {
        maven 'M3'
    }

    stages {

        stage('Deployment') {
            steps {
                script {
                    sh 'ansible targets -i /usr/share/jenkins/ref/inventory.ini -a "echo hi" '
                }
                
            }
        }

    }
}
