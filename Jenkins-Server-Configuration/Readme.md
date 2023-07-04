# Jenkins Configuration

### Accessing Jenkins
- To access Jenkins GUI, open a browser and visit "http://<EC2-Public-IP>:8080"

### Setting up Jenkins
- To Unlock Jenkins, enter the Jenkins Administrative Password which can be found by command: sudo cat /var/lib/jenkins/secrets/initialAdminPassword
- Install Suggested Plugins
- Install additional Plugins such as Maven Integration Plugin, Ansible Plugin, etc.
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
- 