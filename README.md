us-west-1 region infrastructure provisioning with terraform using variables:
- Ec2 Instance (Amazon EC2 ami) 
- Own VPC created
- 2 Subnets (publc and private)
- Internet Gateway
- Route tables (public and private)
- Route associations
- Security Groups - Open 22,80 and 443 port for public and Public Subnet IP for private subnet.
- Using script file to install Ngingx web server
- Get an output