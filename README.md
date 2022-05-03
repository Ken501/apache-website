# Launch internal website running on apache behind a Load Balancer

Hello GitHub, I would like to share a fun project. This Terraform code deploys a redundant simple webpage that is both secure, scalable and highly available. This is not public facing so no HTTPS, DNS, Certificates and CodeDeploy needed for deployment. This will only function within your LAN. This webpage will be running on AWS Auto Scaling Group behind a Load Balancer that has been placed on public subnets in order to forward incoming HTTP requests on port 80 to the targeted webserver. The ASG instances cannot be reached via ssh, http or by hitting the ip/hostname directly as they are placed in private subnets on 2 AWS AZs for high availability and can only communicate via NAT. For this reason AWS SSM was installed to allow remote access without the need for ssh keys or passwords. There are 2 NATs that were placed on public subnets and this is to allow the web server to serve the webpage we create with user data. Network was built with needed resources from gound up for fun :) Feel free to grab a copy and expand for personal projects, learning terraform/aws or just for fun.

# Pre-requisites:

1. Must have Terraform CLI installed and configured
2. An AWS account with programmatic access (access key & secret access key)

# Instructions:

1. Download infrastructure code
2. within variables.tf update access_key and secret_key accordingly with aws credentials
3. cd into "Infrastructure" directory
4. run: terraform init
5. run: terraform apply -auto-approve
6. Grab DNS name from output once all resources have been deployed to reach webpage
7. Once done run: terraform destroy -auto-approve
