# Terraform Configuration

- Installing Terraform on AWS EC2 RHEL instance: https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
- Create a new directory for the Terraform project called "terraform-ec2-instances" (Path: /home/ec2-user/terraform-ec2-instances)
- Navigate to this Directory (/home/ec2-user/terraform-ec2-instances)
- Create a main.tf file

---------------------
Tomcat Configuration:

Run command: sudo vi /etc/profile.d/tomcat.sh

Then edit as per the below section:

#export JAVA_HOME="/usr/lib/jvm/java-17-openjdk"
export CATALINA_HOME=/opt/tomcat
export PATH="$PATH:$CATALINA_HOME/bin"

----------------------
Tomcat Configuration:

Run command: sudo vi /etc/systemd/system/tomcat.service

Then add the below section:

[Unit]
Description=Apache Tomcat Web Application Container
After=syslog.target network.target

[Service]
Type=forking

Environment=CATALINA_PID=/opt/tomcat/temp/tomcat.pid
Environment=CATALINA_HOME=/opt/tomcat
Environment=CATALINA_BASE=/opt/tomcat

ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/shutdown.sh

User=root
Group=root

[Install]
WantedBy=multi-user.target

