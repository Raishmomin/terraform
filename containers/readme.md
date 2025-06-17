## 🚀 Deployment Steps

### 1. Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads) installed
- AWS account with access key and secret
- IAM user with permissions to create EC2,ECS,ECR,VPC resources


### 2. Create the Containers in ECR

```bash
provider "aws" {
  region = "ap-south-1"
}

resource "aws_ecr_repository" "tutedude-backend" {
  name = "tutedude-backend"
}

resource "aws_ecr_repository" "tutedude-frontend" {
  name = "tutedude-frontend"
}

```
##### Initialize and Apply Terraform

```bash
terraform init
terraform validate
terraform plan
terraform apply --auto-approve
```

and after run this command using account id
login aws and create docker docker build and push into AWS ECR

I have already docker builds so just add tag name and push into registry

```bash
# Authenticate
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin <account_id>.dkr.ecr.<region>.amazonaws.com

# Tag and Push Flask
docker tag flask:latest <account_id>.dkr.ecr.ap-south-1.amazonaws.com/flask-backend
docker push <account_id>.dkr.ecr.ap-south-1.amazonaws.com/flask-backend

# Tag and Push Express
docker tag express:latest <account_id>.dkr.ecr.ap-south-1.amazonaws.com/express-frontend
docker push <account_id>.dkr.ecr.ap-south-1.amazonaws.com/express-frontend

```


### 3.Setup environment veriable in Task Definitions

```bash
container_definitions = jsonencode([
    {
      name  = "express-container",
      image = var.express_image_url,
      portMappings = [{
        containerPort = 3000,
        hostPort      = 3000,
        protocol      = "tcp"
      }]
      environment = [
        {
          name  = "API_URL"
          value = "http://${aws_lb.main.dns_name}/api"
        }
      ]
    }
  ])
``` 

### 4. Setup the lisner rules in Load Balancer
##### /api => for backend 

##### / => for frontend
 
```bash 
resource "aws_lb_listener_rule" "flask_api_rule" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.flask_tg.arn
  }

  condition {
    path_pattern {
      values = ["/api/*"]
    }
  }
}
```


### 5. Initialize and Apply Terraform

```bash
terraform init
terraform validate
terraform plan
terraform apply --auto-approve
```

Terraform will:

* Create a VPC, Security Group, ECS, Task Definitions, Load Balancer, ECS Services


### 4. Access Apps

* **Flask**: `http://ecs-alb-1080775681.ap-south-1.elb.amazonaws.com/`
* **Express**: `http://ecs-alb-1080775681.ap-south-1.elb.amazonaws.com/api/`


### 🧹 Destroy Infrastructure

To remove all resources created by Terraform:

```bash
terraform destroy
```
