## 🚀 Deployment Steps

### 1. Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads) installed
- AWS account with access key and secret
- IAM user with permissions to create EC2 resources


### 2. Created the cloning and installation process in this file

This file should install Node.js and Python, clone or fetch your Flask and Express apps, and run them. Example:

```bash
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

```


### 3. Initialize and Apply Terraform

```bash
terraform init
terraform validate
terraform plan
terraform apply --auto-approve
```

Terraform will:

* Create a security group allowing ports `22`, `3000`, and `5000`
* Launch a `t2.micro` EC2 instance with the `install.sh` script
* Automatically start both Flask and Express apps


### 4. Access Apps

* **Flask**: `http://13.204.65.230:5000/`
* **Express**: `http://13.204.65.230:3000/`


### 🧹 Destroy Infrastructure

To remove all resources created by Terraform:

```bash
terraform destroy
```

