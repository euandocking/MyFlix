#!/bin/bash

for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo usermod -aG docker $USER
newgrp docker

#sudo ufw enable
#sudo ufw allow 22/tcp
#sudo ufw allow 80/tcp
#sudo ufw allow 27017/tcp
#sudo ufw allow 3000/tcp
#sudo ufw allow 5000/tcp
#sudo ufw reload

git clone https://github.com/euandocking/MyFlix.git
cd MyFlix
git clone https://github.com/euandocking/MyFlix-Node.git
git clone https://github.com/euandocking/MyFlix-React.git

echo REACT_APP_API_URL=http://3.83.113.19:5000 > init-scripts/.env

#docker compose down

docker compose up --build -d

docker cp init-scripts/videos.json myflix-mongodb:videos.json

docker exec -it myflix-mongodb mongoimport --db myflix --collection videos --file videos.json --jsonArray --username yourUsername --password yourPassword

#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