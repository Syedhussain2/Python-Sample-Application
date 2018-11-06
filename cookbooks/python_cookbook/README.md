# Sparta uber project Python cookbook

**By : Engineering 17**

### **Description :**

Created a Python cookbook which provisions all dependencies for the [Uber Sample Python App](https://github.com/uber/Python-Sample-Application).

We included unit and integration tests to ensure it works correctly.


### **Challenges :**
Our biggest challenge was getting the remote directory working. It would create a directory in the machine but when we tried to access the directory, it would say that the directory does not exist.
After trying to work out the issues with this, we decided to not use the remote directory as it wasn't necessary for the cookbook.

Another challenge we had was figuring out which dependencies were needed to run the app. Looking at the Readme on Uber Sample Python App, as well as the requirements.txt and the requirements-test.txt inside the repo, allowed us to find and install the required dependencies.

Another challenge we faced had to do with displaying the app on the browser. This happened during the final stages of the project, after we finished the cookbook and combined this with the nginx cookbook, when we ran python app.py in the instance, a member of the team would get an authentication error from uber which we suspected had to do with the browser itself. When we tried to open it on a different browser, it worked fine. We tried on chrome again but this time using the incognito window and this too worked. Once we cleared the history and cookies on the browser we tried it out again and it worked.

### **Work Logs :**
1. Created a Vagrant file.
2. Configured and provisioned the vagrant file.
3. Checked if all the requirements were installed and working in the vagrant machine.
4. Created a Python cookbook.
5. Wrote the Unit Tests for the cookbook.
6. Wrote the Integration Tests for the cookbook.
7. Wrote the Recipe for the cookbook.
8. Ran chef exec spec rspec to check if everything was running.
9. Ran Kitchen Test to check if everything was working as it should an was where it should be.
