pipeline {
    agent any

    tools {
        maven 'M3'
    }

        stage('ssh setup') {
            steps {
                script {
                    sh '/usr/share/jenkins/ref/ssh_tasks.sh'
                }
            }
        }
    }
}
