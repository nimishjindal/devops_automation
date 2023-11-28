FROM jenkins/jenkins:2.414.3-jdk17

ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
USER root
RUN apt-get update && apt-get install -y ansible
RUN apt-get install sshpass

USER jenkins

RUN jenkins-plugin-cli --plugins configuration-as-code:1738.v2d8b_a_b_8a_54b_1 workflow-aggregator git job-dsl:1.87 blueocean ansible:285.v2f044b_eb_7a_3e