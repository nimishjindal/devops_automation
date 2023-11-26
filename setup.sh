#!/bin/bash

# ------- setup jq------------"
./install_jq.sh
docker network create jenkins-automated

#------- setup SonarQube------------
#./setup_Sonar.sh

#----- setup Jenkins ---------
./setup_Jenkins.sh

#---- check if job is complete -----
#echo "------------ Application URL will appear once job is complete -----------"
#./Jenkins_job_status.sh

sudo docker-compose -f docker-compose-petclinic.yml up -d