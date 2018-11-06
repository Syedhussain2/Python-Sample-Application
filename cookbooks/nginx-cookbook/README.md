# Nginx Cookbook

### Description
Created a cookbook for Nginx and included both unit and integration tests for it. We then provisioned Nginx as a reverse proxy designed to proxy 'port 80' to the port of our app. The default port of our app is 7000, but it is configurable within the default attributes file.

### Challenges
1. Trying to include all the necessary tests for Nginx.
2. Trying to make the proxy port work without any errors; we were getting bad gateway error 502 for a while.
3. The main error/mistake we made was using 'http://development.local' in the proxy.conf file instead of 'http://localhost'. This made it impossible to vagrant up because Nginx did not recognise development.local yet, as it had not completed the mapping of development.local to 192.168.10.100 (which is done in the Vagrantfile).

### Work Log
1. Added unit and integration tests so we could test that Nginx was running, enabled and installed, as well as testing that the proxy port was working correctly and the file was being inserted into the VM.
2. Added Nginx service and package to our cookbook, then we carried out the tests to check that it was installed, enabled and running.
3. Created attribute and template files so we could use a proxy port in the VM. We then tested this by carrying out the unit and integration tests again.
4. UNIT TESTS: We realised that the proxy port test was failing because it was searching for the variable 'proxy_port' inside the template file (when it wasn't actually there), so we redesigned the test to remove this dependency.
5. INTEGRATION TESTS: We realised that the integration test for the status of the 'http://localhost' was returning a 502, meaning there was a bad gateway. This means that Nginx was not communicating with the upstream server. We realised that this was because we didn't actually have an upstream server for Nginx to communicate with, so we introduced nodejs and an app folder in order to have an upstream server that Nginx could proxy.
6. We then had trouble running the app in the browser, and figured out that this was because we used development.local in the proxy.conf file instead of localhost. Once we changed this, it worked as expected and we could see that the proxy port was configured correctly.
7. In order to get the cookbook ready for the master branch and able to be integrated with the python cookbook and the Uber code, we removed all the nodejs functionality, nodejs tests and the vagrantfile. We then pushed it up to GitHub for our teammates to combine it with their other cookbook and code.
