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

        stage('SonarQube Analysis') {
            environment {
                scannerHome = tool 'sonar-asst'
            }
            steps {
                withSonarQubeEnv('sonar-local-container') {
                    sh "${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=assignment -Dsonar.exclusions=**/*.java -Dcheckstyle.skip=true"
                }
            }
        }

        stage('Maven Build') {
            steps {
                script {
                    sh 'mvn install -Dcheckstyle.skip=true -DskipTests=true'
                }
            }
        }

        stage('Deployment') {
            steps {
                ansiblePlaybook (
                    inventory: '/usr/share/jenkins/ref/inventory',
                    playbook: '/usr/share/jenkins/ref/playbook.yml',
                    extras: '-vvv'
                )
            }
        }

    }
}
