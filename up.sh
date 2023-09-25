#!/bin/bash
source .env
# Bring up the environment
docker compose up -d

echo "Wait for Splunk availability"

echo "Wait for Splunk availability"
until [ $(docker inspect --format='{{.State.Health.Status}}' so1) = healthy ]
do
  echo -n '.'
  sleep 10
done

#
# ... other config steps
#


echo -e "\nWait for login prompt"
until $(curl -s -f -o /dev/null -k --head "http://$SPLUNK_HOST:8000")
do
  echo -n '.'
  sleep 10
done

echo -e "\nUp and Running."
