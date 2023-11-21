# ----- host IP address ---------
PRIVATE_IP=$(ifconfig | grep "inet " | grep -Fv 127.0.0.1 | grep -Fv 10.0.0.63 | awk '{print $2}')
echo "$PRIVATE_IP" > pvt_ip_secret.txt

echo "------- setup Jenkins ------------"
sudo docker build -t jenkinsimage-automation -f dockerfile .
sudo docker-compose -f docker-compose-jenkins.yml up -d