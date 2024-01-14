#!/bin/bash

cd MyFlix
git pull origin main

# Update any necessary configurations

docker-compose down
docker-compose pull
docker-compose up -d
