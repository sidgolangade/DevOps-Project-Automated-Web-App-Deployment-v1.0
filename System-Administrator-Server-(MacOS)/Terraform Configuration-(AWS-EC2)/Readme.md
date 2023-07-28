# DevOps Infrastructure Provisioning with Terraform

This section contains Terraform code to provision an AWS-based infrastructure for a DevOps environment. The infrastructure includes multiple EC2 instances for developer, Jenkins, Ansible, and web/apache tomcat servers.

## Prerequisites

- An AWS account with appropriate access credentials.
- Terraform installed on your local machine.

## Configuration

Before applying the Terraform configuration, ensure that you have the following details:

1. Replace `<YOUR_AWS_REGION>` with your desired AWS region, for example, "us-west-2" or "eu-west-1".

2. Replace `<YOUR_AMI_ID>` with the AMI ID of the desired Amazon Machine Image (AMI) to use for the instances.

3. Replace `<YOUR_KEY_PAIR_NAME>` with the name of your existing EC2 Key Pair to access the instances securely.

## Terraform Configuration

The `main.tf` file contains the Terraform configuration that creates the following AWS resources:

1. Developer EC2 Instance:
   - An EC2 instance for developers with Git pre-installed.

2. Jenkins EC2 Instance:
   - An EC2 instance with Jenkins installed.

3. Ansible EC2 Instance:
   - An EC2 instance with Ansible installed.

4. Web/Apache Tomcat EC2 Instance:
   - An EC2 instance with Apache Tomcat installed.

## Usage

1. Navigate to the directory containing `main.tf`.

2. Initialize Terraform by running the following command:
   ```
   terraform init
   ```

3. Review and modify the variables in the `main.tf` file based on your requirements.

4. Apply the Terraform configuration to create the infrastructure:
   ```
   terraform apply
   ```

5. Confirm the changes and proceed by typing `yes` when prompted.

6. Terraform will provision the AWS resources based on your configuration.

## Clean Up

To destroy the created infrastructure and release AWS resources, run:
```
terraform destroy
```
Confirm the destruction by typing `yes` when prompted.
