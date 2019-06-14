#!/bin/bash
sudo su
yum update -y
yum install -y httpd
service httpd start
chkconfig httpd on
INSTANCE_ID = 'curl http://169.254.169.254/latest/meta-data/instance-id'
echo "<h1>INSTANCE_ID</h1>" /var/www/html/index.html