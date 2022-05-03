#! /bin/bash

# Install Apache
sudo yum upate -y
sudo yum install -y httpd
sudo systemctl enable httpd
sudo systemctl start httpd

# Install SSM
sudo systemctl enable amazon-ssm-agent
sudo systemctl start amazon-ssm-agent
sudo systemctl status amazon-ssm-agent

# Create test index.html
echo "<h1>Deployed via Terraform!</h1>" | sudo tee /var/www/html/index.html