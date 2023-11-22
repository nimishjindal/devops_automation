# ----- host IP address ---------

NETWORK="jenkins-automated"

NETWORK1=$(jq '.[0] | .Containers | map_values(select(.Name | contains("Sonar"))) ' <<< "$(docker network inspect $NETWORK)")

IP_W_SLSH=$(jq 'map(.) | .[0] |.IPv4Address' <<< "$NETWORK1")

IP_W_QUOTE=$(tr "/" " " <<< $IP_W_SLSH)

PRIVATE_IP="$(echo $IP_W_QUOTE | tr "\"" " " | awk '{print $1}')"

echo "$PRIVATE_IP" > pvt_ip_secret.txt

echo "------- setup Jenkins ------------"
sudo docker build -t jenkinsimage-automation -f dockerfile .
sudo docker-compose -f docker-compose-jenkins.yml up -d