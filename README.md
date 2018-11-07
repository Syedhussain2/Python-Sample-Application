# ENGINEERING 17 UBER APP

# Description:

The following ReadMe displays information on a step by step guide on how a platform was created for Uber's application to function identically to the live web application.

# Technologies Used
* Chef
* Jenkins
* AWS
* Atom
* Trello

# How To Download Repository
1. Search for Syedhussain2 in GitHub. [Click Here](https://github.com/Syedhussain2/Uber_App_Engineering17) for the link.
2. Fork/Clone the files displayed.

# Step 1 - NGINX Cookbook
### **Description**
Created a cookbook for Nginx and included both unit and integration tests for it. We then provisioned Nginx as a reverse proxy designed to proxy 'port 80' to the port of our app. The default port of our app is 7000, but it is configurable within the default attributes file.

### **Work Log**
1. Added unit and integration tests so we could test that Nginx was running, enabled and installed, as well as testing that the proxy port was working correctly and the file was being inserted into the VM.
2. Added Nginx service and package to our cookbook, then we carried out the tests to check that it was installed, enabled and running.
3. Created attribute and template files so we could use a proxy port in the VM. We then tested this by carrying out the unit and integration tests again.
4. UNIT TESTS: We realised that the proxy port test was failing because it was searching for the variable 'proxy_port' inside the template file (when it wasn't actually there), so we redesigned the test to remove this dependency.
5. INTEGRATION TESTS: We realised that the integration test for the status of the 'http://localhost' was returning a 502, meaning there was a bad gateway. This means that Nginx was not communicating with the upstream server. We realised that this was because we didn't actually have an upstream server for Nginx to communicate with, so we introduced nodejs and an app folder in order to have an upstream server that Nginx could proxy.
6. We then had trouble running the app in the browser, and figured out that this was because we used development.local in the proxy.conf file instead of localhost. Once we changed this, it worked as expected and we could see that the proxy port was configured correctly.
7. In order to get the cookbook ready for the master branch and able to be integrated with the python cookbook and the Uber code, we removed all the nodejs functionality, nodejs tests and the vagrantfile. We then pushed it up to GitHub for our teammates to combine it with their other cookbook and code.

# Step 2 - PYTHON Cookbook

### **Description**
Created a Python cookbook which provisions all dependencies for the [Uber Sample Python App](https://github.com/uber/Python-Sample-Application). We included unit and integration tests to ensure it works correctly.

### **Work Log**
1. Created a Vagrant file.
2. Configured and provisioned the vagrant file.
3. Checked if all the requirements were installed and working in the vagrant machine.
4. Created a Python cookbook.
5. Wrote the Unit Tests for the cookbook.
6. Wrote the Integration Tests for the cookbook.
7. Wrote the Recipe for the cookbook.
8. Ran chef exec spec rspec to check if everything was running.
9. Ran Kitchen Test to check if everything was working as it should an was where it should be.

# Step 3 - Cookbook Platform
### **Description**
Creation of the platform for both the Nginx and Python cookbooks to be imported in order for the Uber Application to work.

### **Fork The Application**
1. Fork the [GIT Repository](https://github.com/uber/Python-Sample-Application) onto your GitHub account.
2. Open up the file on atom.
###  **Inside The File**
1. In the command line create a berksfile and packer.json, type
```
touch Berksfile packer.json
```
2. In the command line create a Vagrant File, type
```
vagrant init
```

##  **Populate**

###  **Vagrant File**
Insert the following code.

```rb
required_plugins = %w( vagrant-hostsupdater vagrant-berkshelf )

required_plugins.each do |plugin|

  exec "vagrant plugin install #{plugin};vagrant #{ARGV.join(" ")}" unless Vagrant.has_plugin? plugin || ARGV[0] == 'plugin'

End


def set_env vars

  command = <<~HEREDOC

      echo "Setting Environment Variables"

      source ~/.bashrc

  HEREDOC

  vars.each do |key, value|

    command += <<~HEREDOC

      if [ -z "$#{key}" ]; then

          echo "export #{key}=#{value}" >> ~/.bashrc

      fi

    HEREDOC

  end

  return command

end


Vagrant.configure("2") do |config|

  config.vm.box = "base"

  config.vm.define "uberApp" do |uberApp|

    uberApp.vm.box = "ubuntu/xenial64"

    uberApp.vm.network "private_network", ip: "192.168.10.100"

    uberApp.hostsupdater.aliases = ["development.local"]

    uberApp.vm.synced_folder "app", "/home/vagrant/app"


    uberApp.vm.provision "chef_solo" do |chef|

      chef.add_recipe "nginx-cookbook::default"

      chef.add_recipe "python_cookbook::default"

    end

  end

end

```

### **Berks File**
Insert the following code.

```rb
source 'https://supermarket.chef.io'

cookbook '<cookbook name>', git: <Repo link>
i.e.
cookbook 'nginx-cookbook', git: 'git@github.com:ryanlecoutresparta/nginx-cookbook.git'
cookbook 'python_cookbook', git: 'git@github.com:DavidSIJames/Sparta_uber_project_Python_cookbook.git'

```

In order to import the files into the project using the Berks File, in the command line type,
```
berks vendor cookbooks
```

### **Packer.json File**

Insert the following code.

```rb
{

  "variables": {

    "aws_access_key": "",

    "aws_secret_key": "",

    "version": "{{env `GIT_TAG_NAME`}}"

  },

  "builders": [{

    "type": "amazon-ebs",

    "access_key": "{{user `aws_access_key`}}",

    "secret_key": "{{user `aws_secret_key`}}",

    "region": "eu-west-1",

    "source_ami_filter": {

      "filters": {

      "virtualization-type": "hvm",

      "name": "ubuntu/images/*ubuntu-xenial-16.04-amd64-server-*",

      "root-device-type": "ebs"

      },

      "owners": ["099720109477"],

      "most_recent": true

    },

    "instance_type": "t2.micro",

    "ssh_username": "ubuntu",

    "ami_name": "Engineering17-Uber-app-{{timestamp}}"

  }],

  "provisioners":

  [{

    "type": "shell",

    "inline": ["mkdir /home/ubuntu/app"]

  },

  {

    "type": "file",

    "source": "app/",

    "destination": "/home/ubuntu/app"

  },

    {

      "type": "chef-solo",

      "cookbook_paths": ["./cookbooks"],

      "run_list":["python_cookbook::default", "nginx-cookbook::default"]

    }]

}
```

# JENKINS








# Challenges
## **NGINX**

1. Our first challenge was having to include all the necessary unit and integration tests for Nginx and the proxy port functionality, to ensure that things were working as expected.

2. Another challenge was actually being able to see evidence of the proxy port working correctly in the browser. To do this, we had to temporarily bring Node.js into the cookbook, which also meant that further tests were required.

3. Finally, it was a challenge trying to make the proxy port work without any errors. The main error/mistake we made was using 'http://development.local' in the proxy.conf file instead of 'http://localhost'. This made it impossible to vagrant up because Nginx did not recognise development.local yet, as it had not completed the mapping of development.local to 192.168.10.100 (which is done in the Vagrantfile).

## **PYTHON**
1. Our biggest challenge was getting the remote directory working. It would create a directory in the machine but when we tried to access the directory, it would say that the directory does not exist.
After trying to work out the issues with this, we decided to not use the remote directory as it wasn't necessary for the cookbook.

2. Another challenge we had was figuring out which dependencies were needed to run the app. Looking at the Readme on Uber Sample Python App, as well as the requirements.txt and the requirements-test.txt inside the repo, allowed us to find and install the required dependencies.

3. Another challenge we faced had to do with displaying the app on the browser. This happened during the final stages of the project, after we finished the cookbook and combined this with the nginx cookbook, when we ran python app.py in the instance, a member of the team would get an authentication error from uber which we suspected had to do with the browser itself. When we tried to open it on a different browser, it worked fine. We tried on chrome again but this time using the incognito window and this too worked. Once we cleared the history and cookies on the browser we tried it out again and it worked.

## **COOKBOOK Platform**
1. The only challenge faced in this task was ensuring that the most up to date code from the cookbooks was installed into the platform. Everytime, code was updated from either cookbook, it would not automatically update on the platform side. Code had to be run to hook the updated cookbooks.

# Learning Points
* Looking at a pre-built app and looking at its individual needs in order to be able to provision it correctly.
* Ensuring that you test every change made to the code, reflecting that it is interactive with the rest of the code.
* Reinforcing where directories/files/scripts go.
* Taking a step back - looking at alternatives.
* Patience is a virtue.
* Linking appropriate Jenkins tasks.
* Improving researching abilities.
* Errors are good, except when they are bad.


>**Created by: Engineering 17!**
