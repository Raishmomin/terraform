#!/bin/bash
# Update packages and install dependencies
sudo apt update && sudo apt install -y nodejs npm git

# Move to ubuntu home directory
cd /home/ubuntu

# Clone the GitHub repo (Replace with your actual public repo URL)
git clone https://github.com/Raishmomin/raish-tutedude

sudo chown -R ubuntu:ubuntu /home/ubuntu/raish-tutedude

cd raish-tutedude

cd frontend
echo "API_URL=http://${API_URL}:5000" | sudo tee -a .env
sudo npm install
nohup npm start &

