## Create Ansible playbooks for deployment orchestration:

- SSH into the Ansible Server using your preferred method.
- Create a new directory for the Ansible playbooks:
mkdir ansible-playbooks
cd ansible-playbooks
vi deploy-web-app.yml

- If /etc/ansible directory is not present:- 
sudo mkdir /etc/ansible
sudo chown -R $USER:$USER /etc/ansible
sudo chmod -R 755 /etc/ansible
sudo vi /etc/ansible/hosts

### Configuring Passwordless Connection between Ansible Server and Web Server

- Configure SSH access from the Ansible control machine to the target web server(s): Generate an SSH key pair on the Ansible control machine (if you haven't already):
ssh-keygen -t rsa -b 4096 -C "ansible-control-machine"
ssh-copy-id user@target-web-server
- Follow the prompts to generate the key pair. Copy the public key to the target web server(s) where you want to deploy your application:
- cat /home/ec2-user/.ssh/id_rsa.pub
- Copy the above SSH Public Key to Web Server. Steps:
cd ~/.ssh/
vi authorized_keys 
PASTE HERE

- Copy the public key to the target web server(s) where you want to deploy your application:
ssh-copy-id ec2-user@ec2-x-xxx-xx-xxx.eu-west-1.compute.amazonaws.com

### Configuring hosts file on Ansible Server
- sudo vi /etc/ansible/hosts
PASTE the below:
[webserver]
target-web-server ansible_user=user
Replace target-web-server with the hostname or IP address of the target web server, and user with the SSH username.

OPTIONAL:
- Test Ansible connectivity to the target web server(s):
- Verify that Ansible can communicate with the target web server(s) by running a simple ping command:
ansible -i hosts webserver -m ping

### Configuring Ansible Playbook 
- Copy the contents from deploy-web-app.yml to /home/ec2-user/ansible-playbooks/deploy-web-app.yml

