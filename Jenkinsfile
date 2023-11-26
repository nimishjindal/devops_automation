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

        stage('maven clean verify') {
            steps {
                script {
                    sh 'mvn clean -Dcheckstyle.skip=true'
                }
            }
        }

        stage('maven verify') {
            steps {
                script {
                    sh 'mvn verify -Dcheckstyle.skip=true -DskipTests=true'
                }
            }
        }

        stage('Maven Build') {
            steps {
                script {
                    sh './mvnw package -DskipTests -Dcheckstyle.skip=true'
                    sh 'mkdir -p $WORKSPACE/jars && cp target/*.jar $WORKSPACE/jars/petclinic.jar'

                }
            }
        }

        stage('Deployment') {
            steps {
                ansiblePlaybook (
                    inventory: '/usr/share/jenkins/ref/inventory.ini',
                    playbook: '/usr/share/jenkins/ref/playbook.yml',
                    extras: '-vvv'
                )
            }
        }

    }
}
