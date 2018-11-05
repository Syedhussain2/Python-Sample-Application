# Nginx Cookbook

### Description
Created a cookbook for Nginx and included both unit and integration tests for it. We then provisioned Nginx as a reverse proxy designed to proxy 'port 80' to the port of our app. The default port of our app is 3000, but it is configurable within the default attributes file.

### Challenges
1. Trying to include all the necessary tests for Nginx.
2. Trying to make the proxy port work without any errors.
