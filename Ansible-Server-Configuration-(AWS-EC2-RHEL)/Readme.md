# Ansible Playbook: Deploy Web Application to Web Server

This Ansible playbook automates the deployment of a web application to a Web Server (hosted as "webserver"). The playbook ensures the web application is synchronized to the server, installs Python dependencies, and updates necessary configurations for proper execution.

## Prerequisites

1. Ensure you have Ansible installed on your control machine from which you will run this playbook.

2. Create Ansible playbooks for deployment orchestration:
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

## Playbook Structure

The playbook consists of the following tasks:

1. **Copy application code to Web Server**: Synchronizes the application code directory from the Ansible control machine to the Web Server's `/opt/tomcat/webapps/` directory.

2. **Install Web Application dependencies**: Uses pip to install Web Application dependencies from the specified requirements file on the Web Server.

3. **Check if process is running on port 8080**: Checks if a process is currently running on port 8080 on the Web Server.

4. **Kill process running on port 8080**: If a process is found running on port 8080, it will be killed to free up the port for the web application.

5. **Retrieve server IP address**: Uses curl to obtain the IP address of the Web Server, which will be used for updating the ALLOWED_HOSTS setting.

6. **Update ALLOWED_HOSTS setting**: Replaces the existing ALLOWED_HOSTS configuration in `settings.py` file with the IP address of the Web Server to allow incoming requests.

7. **Set permissions on temporary files**: Sets proper permissions (0755) on the temporary files used by Ansible.

8. **Run the web app**: Executes the web application using the `runserver` command, allowing the app to be accessed externally via port 8080.

## Usage

1. Ensure you have properly configured the inventory file to define the "webserver" host with its IP address or hostname.

2. Place the playbook in a file with the ".yml" extension (e.g., `deploy_web_app.yml`).

3. Execute the playbook using the following command:

   ```
   ansible-playbook -i <path_to_inventory_file> deploy_web_app.yml
   ```

   Replace `<path_to_inventory_file>` with the path to your inventory file containing the "webserver" host.

4. Observe the output of the playbook to monitor the progress of each task.

## Note

- Before running this playbook, ensure that the target Web Server is properly set up and accessible from the Ansible control machine.

- Customize the playbook as needed to suit your web application's specific requirements and configurations.

- Ensure you have the necessary permissions and access credentials to perform the tasks specified in the playbook.

