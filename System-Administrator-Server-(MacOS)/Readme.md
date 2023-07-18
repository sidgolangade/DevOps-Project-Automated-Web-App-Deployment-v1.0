## Initial Web Application data transfer from macOS local machine to Developer Server

### Steps:

- Open a terminal on your local machine.
- Navigate to the directory where your web application code is located.
- Use the scp command to securely copy the code to the EC2 instance:
scp -i /path/to/your/key.pem -r /path/to/your/webapp user@<EC2-Instance-Public-IP>:/path/on/ec2/instance
- The scp command will securely copy the entire directory (including all files and subdirectories) to the specified path on the EC2 instance.

