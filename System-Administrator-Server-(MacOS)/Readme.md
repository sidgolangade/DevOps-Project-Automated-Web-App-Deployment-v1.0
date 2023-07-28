# Terraform Setup on Local Machine

This section provides a Terraform configuration for provisioning AWS EC2 instances. 

## Step 1: Installing Terraform

First, install Terraform on your local machine. You can follow the official HashiCorp guide for installing Terraform: https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

## Step 2: Setting Up the Terraform Project

1. Create a new directory for the Terraform project called "terraform-ec2-instances":

   ```bash
   mkdir /home/ec2-user/terraform-ec2-instances
   ```

2. Navigate to the newly created directory:

   ```bash
   cd /home/ec2-user/terraform-ec2-instances
   ```

## Step 3: Create a `main.tf` File

1. To start defining your Terraform configuration, create a `main.tf` file inside the "terraform-ec2-instances" directory. You can use any text editor of your choice, such as `nano` or `vi`:

   ```bash
   nano main.tf
   ```

2. Add your Terraform code to the `main.tf` file. This is where you define the AWS resources you want to provision, such as EC2 instances, security groups, and other infrastructure components.

3. Save the file and exit the text editor.