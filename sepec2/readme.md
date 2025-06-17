## 🚀 Deployment Steps

### 1. Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads) installed
- AWS account with access key and secret
- IAM user with permissions to create EC2 resources


### 2. Create the cloning and installation process 

For Backend
This file should install Python, clone or fetch your Flask app, and run them. Example:

```bash
# Update packages and install dependencies
sudo apt update && sudo apt install -y python3-pip python3-venv

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

```

For Frontend
This file should install Nodejs, clone or fetch your Express app, and run them. Example:

```bash
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

```


### 3. Pass the backend url to frontend using templatefile

```bash
resource "aws_instance" "express" {
  ami                    = "ami-0f918f7e67a3323f0"
  instance_type          = "t2.micro"
  key_name               = var.key_name
  subnet_id              = aws_subnet.main.id
  vpc_security_group_ids = [aws_security_group.express_sg.id]
  user_data = templatefile("user_data_express.sh", {
    API_URL = "${aws_instance.flask.public_ip}"
  })
  tags = {
    Name = "express-server"
  }
}
``` 


### 4. Initialize and Apply Terraform

```bash
terraform init
terraform validate
terraform plan
terraform apply --auto-approve
```

Terraform will:

* Create a security group allowing ports `22`, `3000`, and `5000`
* Launch a `t2.micro` EC2 instance with the `install.sh` script
* Automatically start both Flask and Express apps and connected with env file


### 4. Access Apps

* **Flask**: `http://13.201.70.230:3000/`
* **Express**: `http://13.235.244.190:5000/`


### 🧹 Destroy Infrastructure

To remove all resources created by Terraform:

```bash
terraform destroy
```
