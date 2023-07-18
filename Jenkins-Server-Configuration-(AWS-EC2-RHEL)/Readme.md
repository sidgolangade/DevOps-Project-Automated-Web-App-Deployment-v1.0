# Jenkins Configuration

### Accessing Jenkins
- To access Jenkins GUI, open a browser and visit "http://<EC2-Public-IP>:8080"

### Setting up Jenkins
- To Unlock Jenkins, enter the Jenkins Administrative Password which can be found by command: sudo cat /var/lib/jenkins/secrets/initialAdminPassword
- Install Suggested Plugins
- Install additional Plugins such as Maven Integration Plugin, Ansible Plugin, Publish over SSH, etc.

- Configure Jenkins interaction with GitHub repository: 
Go to your GitHub account settings > Navigate to "Developer settings" > "Personal access tokens." > Tokens (classic) > Click on "Generate new token. (classic)" > Provide a suitable description for the token. > Under "Select scopes," make sure to check the necessary scopes for your project (e.g., repo, admin:repo_hook, etc.). > Click "Generate token." > Copy the generated access token. Keep it secure, as you won't be able to retrieve it later.

- Configure Jenkins credentials: 
In Jenkins, navigate to "Manage Jenkins" > "Credentials." > Click on "Global" (or any other desired domain) > "Add Credentials." > Choose the appropriate credential type (e.g., "Username with password") and provide the required information. > Save the credential, ensuring that it has an easily identifiable name.

- Configure GitHub webhook:
In your GitHub repository, go to "Settings" > "Webhooks" > "Add webhook."
Set the Payload URL to the Jenkins URL followed by /github-webhook/ (e.g., http://jenkins-server/github-webhook/).
Select the content type as "application/json."
Choose the events that should trigger the webhook (e.g., "Push events" for building on each push).
Ensure the "Active" checkbox is selected.
Save the webhook configuration.

- Configure Jenkins to pick up code updates and build:
Open Jenkins in a web browser by accessing the Jenkins Server's IP or hostname.
Log in to Jenkins.
Create a new Jenkins pipeline job.
Build Triggers: Click Check for "GitHub hook trigger for GITScm polling"
Pipeline > Definition: GitHub hook trigger for GITScm polling > SCM: Git > Repositories: Repository URL (https://github.com/sidgolangade/Web-Application-Repository.git)
Credentials > Add
Branches to Build > Branch > ¨/main
Configure any other required settings for your pipeline.
Save the pipeline configuration.
Jenkins will automatically trigger a build whenever there are code updates in the GitHub repository.

### Configuring SSH on Jenkins Server (Passwordless)

Certainly! To establish a passwordless SSH connection between the Jenkins Server and the Ansible Server, you need to generate SSH key pairs and configure the necessary authentication settings. Here are the steps to achieve this:

1. SSH Key Generation on Jenkins Server:
   - Open a terminal or command prompt on the Jenkins Server.
   - Generate an SSH key pair by running the following command:
     ```bash
     ssh-keygen -t rsa -b 4096
     ```
   - You can press Enter to accept the default file location and passphrase (leave it blank for a passwordless key) or provide your preferred values.
   - This will generate the SSH key pair: a private key (`id_rsa`) and a public key (`id_rsa.pub`).

2. Configure SSH Access on the Ansible Server:
   - Log in to the Ansible Server using your preferred method.
   - Create the `.ssh` directory in the home directory (if it doesn't exist):
     ```bash
     mkdir -p ~/.ssh
     ```
   - Change the permissions for the `.ssh` directory:
     ```bash
     chmod 700 ~/.ssh
     ```
   - Create or open the `authorized_keys` file in the `.ssh` directory:
     ```bash
     touch ~/.ssh/authorized_keys
     ```
   - Open the `authorized_keys` file with a text editor.
   - Copy the contents of the `id_rsa.pub` file from the Jenkins Server and paste it into a new line in the `authorized_keys` file.
   - Save and close the `authorized_keys` file.

3. Test the SSH Connection:
   - From the Jenkins Server, attempt to SSH into the Ansible Server:
     ```bash
     ssh ec2-user@ansible-server.example.com
     ```
   - If the connection is successful and doesn't prompt for a password, the passwordless SSH setup is working correctly.
   - Exit the SSH session by typing `exit` or pressing `Ctrl + D`.

Now, you should have a passwordless SSH connection established between the Jenkins Server and the Ansible Server. You can use the SSH private key (`id_rsa`) from the Jenkins Server to authenticate and execute SSH commands on the Ansible Server.

### Utilizing the Jenkins Credentials Binding Plugin to securely retrieve the SSH private key:

Install the Jenkins Credentials Binding Plugin:

Log in to your Jenkins server.
Go to "Manage Jenkins" > "Manage Plugins".
Navigate to the "Available" tab.
Search for "Credentials Binding" in the filter box.
Check the box next to "Credentials Binding" and click on the "Install without restart" button.
Create a Jenkins Credential for SSH private key:

Go to your Jenkins project and click on "Configure" to edit the Jenkins pipeline configuration.
Scroll down to the "Build Environment" section.
Check the "Use secret text(s) or file(s)" checkbox.
Click on the "Add" button to add a new credential.
In the "Kind" dropdown menu, select "SSH Username with private key".
Fill in the required fields:
Username: Provide the SSH username (e.g., ec2-user).
Private Key: Choose "Enter directly".
In the "Private Key" textarea, paste the SSH private key. (For Private SSH Key, go to Jenkins Server: sudo cat /home/ec2-user/.ssh/id_rsa)
If your SSH private key is encrypted with a passphrase, enter it in the "Passphrase" field.
Click on the "Add" button to save the credential.


Update the Jenkinsfile to use withCredentials block:

In your Jenkinsfile, locate the stage('Deploy') section or the relevant stage where you need to use the SSH private key.
Replace the existing sh block with the withCredentials block.
Use the credential ID of the SSH private key credential you created in the previous step.

Save and run the Jenkins pipeline:

Save the changes to the Jenkinsfile.
Run the Jenkins pipeline either by triggering it manually or according to your configured triggers.
During runtime, Jenkins will securely retrieve the SSH private key from the credential and set it as the value of the $SSH_PRIVATE_KEY environment variable within the withCredentials block.
The SSH command within the block can access and use the private key value through the environment variable.

## Jenkinsfile Configuration

- To start jenkins
sudo systemctl start jenkins