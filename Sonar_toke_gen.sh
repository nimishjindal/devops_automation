SONAR_HOST="http://localhost:9000"
SONAR_LOGIN="admin"
SONAR_PASSWORD="newpassword"

TOKEN_NAME="jenkins_token"

# Wait for SonarQube to start
echo "Waiting for SonarQube to start. This will take upto 40 seconds ..."
until curl --output /dev/null --silent --head --fail "$SONAR_HOST"; do
    printf '.'
    sleep 30
done

sleep 10

#change password
curl --location --request POST -u $SONAR_LOGIN:admin "$SONAR_HOST/api/users/change_password?login=$SONAR_LOGIN&previousPassword=admin&password=$SONAR_PASSWORD"

# Generate token
RESPONSE=$(curl -X POST -u $SONAR_LOGIN:$SONAR_PASSWORD "$SONAR_HOST/api/user_tokens/generate?name=$TOKEN_NAME")

if [ $? -eq 0 ]; then
    TOKEN=$(echo "$RESPONSE" | jq -r '.token')
    printf "SONAR_PASSWORD_SH='%s'" "$TOKEN" > .env

    echo "Token saved"
else
    echo "Failed to generate token"
fi