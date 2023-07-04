# Define provider
provider "aws" {
  region = "eu-west-1"  # Replace with your desired region
}

# Create EC2 instances
resource "aws_instance" "ec2_instances" {
  count         = 3
  ami           = "ami-013d87f7217614e10"  # Replace with the desired AMI ID
  instance_type = "t2.micro"      # Replace with the desired instance type

  key_name = "NEW_EC2_KP"         # Replace with the name of your key pair

  # Provisioner for SSH connection
  connection {
    type        = "ssh"
    user        = "ec2-user"  # Replace with the desired SSH username for your AMI
    private_key = file("/home/ec2-user/NEW_EC2_KP.pem")  # Replace with the path to your private key file
    host        = self.public_ip
  }

  # Provisioner for Jenkins installation on SG-Jenkins-Server
  provisioner "remote-exec" {
    inline  = [
      "sudo yum update -y",
      "sudo yum install -y wget",
      "sudo yum install -y java-17-openjdk",
      "sudo wget -O /etc/yum.repos.d/jenkins.repo     https://pkg.jenkins.io/redhat-stable/jenkins.repo",
      "sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key",
      "sudo yum install -y jenkins",
      "sudo systemctl daemon-reload",
      "sudo systemctl start jenkins"
    ]
  }

  # Provisioner for Ansible installation on SG-Ansible-Server
  provisioner "remote-exec" {
    inline  = [
      "sudo yum update -y",
      "sudo yum install -y wget",
      "sudo yum install -y epel-release",
      "sudo yum install -y git",
      "sudo yum install -y python3 python3-pip",
      "sudo pip3 install ansible",
     #"sudo su - ansible -c 'ssh-keygen -t rsa -N \"\" -f ~/.ssh/id_rsa'",
     #"cat /home/ansible/.ssh/id_rsa.pub >> /home/ansible/.ssh/authorized_keys",
     #"chmod 600 /home/ansible/.ssh/authorized_keys"
    ]
  }

  # Provisioner for Apache Tomcat installation on SG-Web-Server
  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y java-17-openjdk",
      "yum install -y curl tar wget",
      "sudo useradd -r tomcat",
      "curl https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.10/bin/apache-tomcat-10.1.10.tar.gz -o apache-tomcat.tar.gz",
      "tar -zxvf apache-tomcat.tar.gz",
      "sudo mv apache-tomcat-10.1.10 tomcat10",
      "sudo mv tomcat10 /opt/tomcat",
      "export JAVA_HOME=/usr/lib/jvm/java-17-openjdk",
      "export CATALINA_HOME=/opt/tomcat",
      "sudo sh -c 'echo \"export JAVA_HOME=/usr/lib/jvm/java-17-openjdk\" >> /etc/profile.d/tomcat.sh'",
      "sudo sh -c 'echo \"export CATALINA_HOME=/opt/tomcat\" >> /etc/profile.d/tomcat.sh'",
      "sudo /opt/tomcat/bin/catalina.sh start",
  ]
}

  # Tags
  tags = {
    Name = "SG-${element(["Jenkins-Server", "Ansible-Server", "Web-Server"], count.index)}"
  }
}
