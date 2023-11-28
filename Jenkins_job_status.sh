color="none"

while [ "$color" != "blue" ]; do
  RESPONSE=$(curl -X GET "http://localhost:8080/job/petclinic/api/json?pretty=true")
  echo "The Jenkins job is Still running..."
  if [ $? -eq 0 ]; then
      color=$(echo "$RESPONSE" | jq -r '.jobs' | jq '.[0]' |jq -r '.color')
  else
      color="error"
      echo "unable to hit api"
      echo RESPONSE
  fi

  sleep 20
done

echo "The job completed successfully. Go to http://localhost:8082"
