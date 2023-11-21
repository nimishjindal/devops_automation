echo "------- setup SonarQube------------"
sudo docker-compose -f docker-compose-sonar.yml up -d

./Sonar_toke_gen.sh