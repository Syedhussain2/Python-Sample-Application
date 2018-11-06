# Nginx Cookbook

### Description
Created a cookbook for Nginx and included both unit and integration tests for it. We then provisioned Nginx as a reverse proxy designed to proxy 'port 80' to the port of our app. The default port of our app is 7000, but it is configurable within the default attributes file.

### Challenges
1. Trying to include all the necessary tests for Nginx.
2. Trying to make the proxy port work without any errors; we were getting bad gateway error 502 for a while - finally managed to fix it by changing the proxy.conf and default recipe files.
3. The main error/mistake we made was using 'http://development.local' in the proxy.conf file instead of 'http://localhost'. This made it impossible to vagrant up because Nginx did not recognise development.local yet, as it had not completed the mapping of development.local to 192.168.10.100 (which is done in the Vagrantfile). 
