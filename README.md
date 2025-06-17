### 1: Deploy Both Flask and Express on a Single EC2 Instance

##### Flask: http://13.204.65.230:5000/
##### Express: http://13.204.65.230:3000/
##### Deployment process [README.MD](terraform/readme.md)


### 2: Deploy Flask and Express on Separate EC2 Instances

##### Flask: http://13.201.70.230:3000/
##### Express: http://13.235.244.190:5000/
##### Deployment process [README.MD](sepec2/readme.md)


### 3. Deploy Flask and Express Using Docker and AWS Services

##### Flask: http://ecs-alb-1080775681.ap-south-1.elb.amazonaws.com/
##### Express: http://ecs-alb-1080775681.ap-south-1.elb.amazonaws.com/api/
##### Deployment process [README.MD](containers/readme.md)
