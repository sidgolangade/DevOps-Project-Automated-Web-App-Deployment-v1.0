# Web Application Deployment Pipeline

This Jenkinsfile defines a continuous integration and deployment pipeline for deploying a web application to an Ansible-managed server. The pipeline utilizes Jenkins, Git, and Ansible to achieve the deployment process.

## Pipeline Stages

The pipeline consists of the following stages:

### Stage 1: Checkout

This stage checks out the code of the web application from a specified GitHub repository. It ensures a clean workspace before cloning the code using the "git" command.
Comments:
// Clean workspace and checkout the code from the GitHub repository
// Checkout the code from the specified GitHub repository (branch: main).
// The 'git' step is used to clone the repository and check out the specified branch.
// The repository URL is 'https://github.com/ameyapb/django-jenkins-ansible-terraform-integration.git'.
// The branch to be checked out is 'main'.

### Stage 2: Deploy to Ansible Server

In this stage, the built application code is securely copied to the Ansible Server using the `rsync` command. The `withCredentials` block retrieves the private SSH key from Jenkins credentials to authenticate the `rsync` and `ssh` commands.
Comments:
// Copy the built application code to the Ansible Server
// The 'withCredentials' block securely retrieves the private SSH key from Jenkins credentials.
// The SSH key is necessary to authenticate the rsync and ssh commands below. 
// Uses rsync to synchronize the local application code to the Ansible Server.
// The '-e' option specifies the SSH command to use for remote shell connection.
// The '-i' option passes the private SSH key for authentication.
// The '--exclude venv/' option excludes the 'venv/' directory from synchronization.
// './' indicates the current directory as the source for rsync.
// 'ec2-user@<ansible-server-hostname>.amazonaws.com:/home/ec2-user/ansible-data/' is the destination path on the Ansible Server.

### Stage 3: Deploy using Ansible

This stage runs an Ansible playbook on the Ansible Server to deploy the web application. The `withCredentials` block securely retrieves the private SSH key from Jenkins credentials for authentication. The `ssh` command connects remotely to the Ansible Server, and the `ansible-playbook` command is executed to perform the deployment.
Comments:
// Run Ansible playbook on the Ansible Server
// The 'withCredentials' block securely retrieves the private SSH key from Jenkins credentials.
// The SSH key is necessary to authenticate the SSH command and run Ansible playbook.
// Uses SSH to remotely connect to the Ansible Server.
// The '-o StrictHostKeyChecking=no' option disables strict host key checking to avoid interactive prompts.
// The '-o UserKnownHostsFile=/dev/null' option avoids storing host keys in the known_hosts file.
// The '-i "$SSH_PRIVATE_KEY"' option passes the private SSH key for authentication.
// 'ec2-user@<ansible-server-hostname>.amazonaws.com' is the Ansible Server's address.
// 'ansible-playbook -i /etc/ansible/hosts /home/ec2-user/ansible-data/ansible-playbooks/deploy-web-app.yml' is the command to run the Ansible playbook.

## Important Notes

- Before using this pipeline, ensure that you have set up Jenkins with appropriate credentials for accessing the GitHub repository and the Ansible Server.

- Replace `<Web-App-Repository>` with the actual URL of your web application's GitHub repository in the `git` step of the "Checkout" stage.

- Replace `<ansible-server-hostname>` with the actual hostname or IP address of your Ansible Server in the "Deploy to Ansible Server" and "Deploy using Ansible" stages.

- Adjust the AMI IDs, instance types, key pair names, and other configurations as per your specific requirements.

## Post-Deployment Actions

The pipeline includes post-deployment actions executed based on the outcome of the deployment:

- If the deployment is successful, the Jenkins console displays the message "Web App Deployment successful!" The success stage can be extended to include additional actions, such as notifications or triggering downstream pipelines.
Comments:
// Actions to be executed when the pipeline is successful.
// The 'echo' command displays the success message in the Jenkins console.
// You can add additional actions here if needed, such as notifications or triggers for other pipelines.

- If the deployment fails, the Jenkins console displays the message "Web App Deployment failed!" The failure stage can be extended to include additional actions, such as sending notifications or performing cleanup tasks.
Comments:
// Actions to be executed when the pipeline fails.
// The 'echo' command displays the failure message in the Jenkins console.
// You can add additional actions here, such as sending notifications or performing cleanup tasks.

## Usage

1. Create a Jenkins job and link it to this Jenkinsfile.

2. Configure Jenkins credentials for accessing the GitHub repository and the Ansible Server, including the SSH private key for authentication.

3. Run the Jenkins job to trigger the pipeline, which will deploy the web application to the Ansible Server.

4. Monitor the Jenkins console for deployment progress and outcomes.