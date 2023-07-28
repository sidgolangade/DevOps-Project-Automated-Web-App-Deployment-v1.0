# Developer Server Conifguration - Git Setup

This section contains a step-by-step guide for setting up and configuring Git for working with the "Web-Application-Repository." The instructions below will help you properly clone, configure, and push code updates to your GitHub repository.

## Prerequisites

Before starting the Git setup, ensure you have the following:

- **GitHub Personal Access Token**: Generate a personal access token on GitHub, which will be used for authentication during Git operations. Replace `<personal_access_token>` with your generated access token.

## Git Configuration Steps

Follow these steps to set up Git for your Web Application Repository:

1. **Clone the Repository**:

   ```
   git clone https://github.com/sidgolangade/Web-Application-Repository.git
   ```

   Clone the remote repository to your local machine using the above command.

2. **Change Directory**:

   ```
   cd Web-Application-Repository
   ```

   Navigate to the cloned repository directory.

3. **Set Remote URL with Personal Access Token**:

   ```
   git remote set-url origin https://<personal_access_token>@github.com/sidgolangade/Web-Application-Repository.git
   ```

   Replace `<personal_access_token>` with the GitHub personal access token you generated earlier. This step ensures you can securely push updates to the repository using the token for authentication.

4. **Create Jenkinsfile**:

   ```
   touch Jenkinsfile
   ```

   Create a new file named `Jenkinsfile`. You can use this file to define your Jenkins pipeline configuration.

5. **Add and Commit Changes**:

   ```
   git add .
   git commit -m "Code updates"
   ```

   Add the changes to the staging area and commit them with an appropriate commit message.

6. **Push Changes to GitHub**:

   ```
   git push origin main
   ```

   Push the committed changes to the "main" branch of the GitHub repository.

## Note

- Ensure you replace `<personal_access_token>` in the commands with your actual GitHub personal access token.

- The Jenkinsfile mentioned in step 4 is a blank file. You need to add your customer jenkins pipeline configuration in this file.

- These instructions assume that you have already set up Git on your local machine. If not, make sure to install Git and configure it with your username and email address before performing these steps.