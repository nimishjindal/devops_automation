pipeline {
    agent any

    tools {
        maven 'M3'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/spring-projects/spring-petclinic.git'
            }
        }

        stage('maven clean') {
            steps {
                script {
                    sh 'mvn clean verify -Dcheckstyle.skip=true'
                }
            }
        }

        stage('Maven Build') {
            steps {
                script {
                    sh 'mvn verify package -DskipTests -Dcheckstyle.skip=true'
                    sh 'mkdir -p $WORKSPACE/jars && cp target/*.jar $WORKSPACE/jars/petclinic.jar'
                }
            }
        }

        stage('Deployment') {
            steps {
                ansiblePlaybook (
                    inventory: '/usr/share/jenkins/ref/inventory.ini',
                    playbook: '/usr/share/jenkins/ref/playbook.yml',
                )
            }
        }

    }
}
