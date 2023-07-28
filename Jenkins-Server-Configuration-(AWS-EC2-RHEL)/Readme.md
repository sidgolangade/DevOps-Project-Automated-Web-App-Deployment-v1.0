**Manual Passwordless Authentication and GitHub Webhook Setup**

This section contains the necessary steps to achieve manual passwordless authentication between the Jenkins server and Ansible server, as well as configuring a GitHub webhook for automated triggering of Jenkins pipelines upon repository changes. This setup establishes secure and seamless communication between the servers and enables efficient and automated deployment processes.

**Manual Passwordless Authentication**

**Step 4.1: Prepare SSH Key and Permissions**
On the Jenkins server, ensure the SSH key and permissions are set up correctly to interact with the Ansible Server. Run the following commands to grant required permissions to the SSH directory and authorized_keys file:
```bash
sudo chown -R ec2-user:ec2-user ~/.ssh
chmod 700 ~/.ssh
```

**Step 4.2: Copy Jenkins Server Public Key to Ansible Server**
Copy the public key from the Jenkins server (/home/ec2-user/.ssh/id_rsa.pub) and paste it into the Ansible server's authorized_keys file (/home/ec2-user/.ssh/authorized_keys) to establish passwordless authentication.

**Step 4.3: Configure Jenkins Server**
1. **Access Jenkins Web Interface:**
   Open your web browser and navigate to the Jenkins server using its public IP address and port 8080: http://<EC2-Public-IP>:8080

2. **initialAdminPassword Setup:**
   Run the following command on Jenkins Server to get the initialAdminPassword and provide it on the Jenkins Web Interface prompt:
   ```bash
   sudo cat /var/lib/jenkins/secrets/initialAdminPassword
   ```

3. **Install Suggested Plugins:**
   Jenkins will prompt you to install suggested plugins. Proceed with the installation to enable essential features for continuous integration and deployment pipelines.

4. **Create Jenkins User Credentials:**
   Go to "Manage Jenkins" > "Manage Users" > "Create User" and provide necessary details to create a user for Jenkins authentication.

5. **Install Plugins for SSH Authentication:**
   Go to "Manage Jenkins" > "Manage Plugins" > "Available" tab. Search for "Publish over SSH" and install the plugin without restarting Jenkins.

**GitHub Webhook Configuration**

**Step 4.4.1: Access GitHub Repository Settings**
Go to your GitHub repository, and in the top navigation bar, click on "Settings."

**Step 4.4.2: Add Webhook**
In the left sidebar of the repository settings, click on "Webhooks." Then, click on the "Add webhook" button.

**Step 4.4.3: Configure Payload URL**
Set the "Payload URL" to the Jenkins URL followed by /github-webhook/, such as: http://jenkins-server/github-webhook/. Select the "Content type" as "application/json."

**Step 4.4.4: Choose Events**
Choose the events that should trigger the webhook, e.g., select "Just the push event" to trigger the Jenkins pipeline on repository pushes.

**Step 4.4.5: Ensure Webhook is Active**
Check the "Active" checkbox to enable the webhook.

**Step 4.4.7: Save Webhook Configuration**
Click the "Save webhook" button to finalize the webhook configuration.

**Jenkins Pipeline Configuration**

**Step 4.5.1: Create a New Pipeline Job**
Go to Jenkins' main dashboard and click on "New Item" to create a new pipeline job. Name the job and choose "Pipeline" as the type.

**Step 4.5.2: Enable GitHub Webhook Trigger**
In the pipeline job configuration, under "Build Triggers," check the box for "GitHub hook trigger for GITScm polling" to enable the pipeline to be triggered by the GitHub webhook.

**Step 4.5.3: Configure SCM and Repository**
Under "Pipeline," choose "Pipeline script from SCM" as the pipeline definition. Select "Git" as the SCM, and provide the URL of your GitHub repository.

**Step 4.5.4: Add Jenkins Credentials**
Click on "Add" under "Credentials" to add your Jenkins credentials for SSH authentication. Provide the Jenkins Server private key.

**Step 4.5.5: Specify Branch to Build**
In the "Branches to build" field, specify the branch specifier to trigger the pipeline on changes to the specified branch.

**Step 4.5.6: Apply Configuration**
Click "Apply" to save the pipeline job configuration.

With these configurations, the Jenkins pipeline is set up to receive triggers from the GitHub webhook. It will automatically execute the build, testing, and deployment processes defined in the Jenkinsfile whenever changes are pushed to the specified branch of the GitHub repository.