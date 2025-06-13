#!/bin/bash
# Update packages and install dependencies
sudo apt update && sudo apt install -y python3-pip python3-venv nodejs npm git

# Move to ubuntu home directory
cd /home/ubuntu

# Clone the GitHub repo (Replace with your actual public repo URL)
git clone https://github.com/Raishmomin/raish-tutedude

cd raish-tutedude

# Setup Flask Backend
cd backend
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
nohup flask run --host=0.0.0.0 --port=5000 &

# Setup Express Frontend
cd ../frontend
npm install
nohup npm start &
