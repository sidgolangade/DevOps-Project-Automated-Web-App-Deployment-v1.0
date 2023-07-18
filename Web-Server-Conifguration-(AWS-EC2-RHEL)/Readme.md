To Start Tomcat:
sudo /opt/tomcat/bin/startup.sh

If the Tomcat service failed to start with an exit code of 203/EXEC. This suggests that the `startup.sh` script is unable to execute.

To troubleshoot this issue further, please try the following steps:

1. Confirm the ownership and permissions of the `/opt/tomcat` directory:
   ```shell
   ls -ld /opt/tomcat
   ```

   Ensure that the directory is owned by the correct user (e.g., `root`) and has proper permissions.

2. Verify the ownership and permissions of the Tomcat files and directories inside `/opt/tomcat`:
   ```shell
   ls -l /opt/tomcat
   ```

   Ensure that the files and directories under `/opt/tomcat` are owned by the appropriate user (e.g., `root`) and have the necessary permissions.

3. Check if SELinux is enabled and may be interfering with Tomcat's execution:
   ```shell
   getenforce
   ```

   If SELinux is enabled and enforcing, it may be necessary to adjust the SELinux context for Tomcat files. You can temporarily set SELinux to permissive mode for testing purposes using the following command:
   ```shell
   sudo setenforce 0
   ```

   Try starting the Tomcat service again:
   ```shell
   sudo systemctl start tomcat
   ```

   Check the service status to see if it started successfully:
   ```shell
   sudo systemctl status tomcat
   ```

   If the service starts successfully after disabling SELinux, you may need to adjust the SELinux context for the Tomcat files using the `chcon` command.

Here are the steps to do so:

1. Identify the directory that contains your Tomcat files. In your case, it appears to be `/opt/tomcat`.

2. Run the `chcon` command to apply the appropriate SELinux context recursively to the Tomcat files and directories. Replace `/opt/tomcat` with the actual path to your Tomcat installation directory if it differs:
   ```shell
   sudo chcon -R --type=httpd_sys_content_t /opt/tomcat
   ```

   This command will set the SELinux context to `httpd_sys_content_t` for all files and directories within `/opt/tomcat`, allowing them to be accessed by the Apache HTTP server.

3. Restart the Tomcat service:
   ```shell
   sudo systemctl restart tomcat
   ```

   This step ensures that Tomcat is using the updated SELinux context.

4. Verify that the Tomcat service starts successfully and that your web applications function as expected.

By applying the appropriate SELinux context, you can maintain the security provided by SELinux while allowing Tomcat to operate correctly.

Note: It's generally recommended to keep SELinux enabled for enhanced system security. Disabling SELinux should be considered a temporary troubleshooting step, and adjusting the SELinux context is preferable when re-enabling SELinux.

-----------------------
To start tomcat:

cd /opt/tomcat/bin
./startup.sh
