#!/bin/bash

# This script is used to start the application.
pathr=$(pwd)
echo "Starting application in ${pathr}"

docker compose --env-file "${pathr}/docker.env" pull && docker compose --env-file "${pathr}/docker.env" up -d 

sudo apt-get update
sudo apt-get install certbot
sudo apt-get install python3-certbot-nginx

sudo certbot --nginx -d "msostream.live" --agree-tos  --email "l.jonas.1@web.de" --redirect


echo "0 12 * * * /usr/bin/certbot renew --quiet" | sudo tee -a /etc/crontab 

docker compose --env-file "${pathr}/docker.env" restart nginx

