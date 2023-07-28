To start and stop Tomcat, you can execute the following commands on your server:

## Start Tomcat:

Open a terminal or SSH into your server, and navigate to the Tomcat installation directory (e.g., `/opt/tomcat/bin/`). Then, run the `startup.sh` script:

```bash
cd /opt/tomcat/bin/
./startup.sh
```

The script will start Tomcat, and you should see the Tomcat server starting up, with logs displayed on the terminal.

## Stop Tomcat:

To stop Tomcat, again navigate to the Tomcat installation directory (e.g., `/opt/tomcat/bin/`) and run the `shutdown.sh` script:

```bash
cd /opt/tomcat/bin/
./shutdown.sh
```

The script will initiate the shutdown process, and you should see the Tomcat server stopping, with logs displayed on the terminal.

## Note:

- Make sure you have the necessary permissions to execute the scripts. If needed, you can use `chmod` to make the scripts executable:

  ```bash
  chmod +x startup.sh shutdown.sh
  ```