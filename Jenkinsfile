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

        stage('Deploy') {
            steps {
                script {
                    sh 'mvn install -Dcheckstyle.skip=true -DskipTests=true'
                }
            }
        }
    }

    post {
        success {
            sh 'JENKINS_NODE_COOKIE=dontkill nohup java -jar target/spring-petclinic-3.1.0-SNAPSHOT.jar --server.port=8081 &'
        }
    }
}
