#
# Cookbook:: python_cookbook
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

apt_update 'update_sources' do
  action :update
end

package 'python2.7'
package 'python-pip'
package 'libncurses5-dev'
package 'libffi-dev'

execute "install flask via pip" do
  command "pip2 install flask==0.10.1"
end

execute "install Jinja2 via pip" do
  command "pip2 install Jinja2==2.7.3"
end

execute "install MarkupSafe via pip" do
  command "pip2 install MarkupSafe==0.23"
end

execute "install Werkzeug via pip" do
  command "pip2 install Werkzeug==0.9.6"
end

execute "install gnureadline via pip" do
  command "pip2 install gnureadline==6.3.3"
end

execute "install itsdangerous via pip" do
  command "pip2 install itsdangerous==0.24"
end

execute "install rauth via pip" do
  command "pip2 install rauth==0.7.0"
end
execute "install requests via pip" do
  command "pip2 install requests==2.3.0"
end
execute "install wsgiref via pip" do
  command "pip2 install wsgiref==0.1.2"
end
execute "install gunicorn via pip" do
  command "pip2 install gunicorn==18.0"
end
execute "install Flask-SSLify via pip" do
  command "pip2 install Flask-SSLify==0.1.4"
end
execute "install pytest via pip" do
  command "pip2 install pyTest==2.5.2"
end
execute "install pytest-cov via pip" do
  command "pip2 install pytest-cov==1.6"
end
execute "install betamax via pip" do
  command "pip2 install betamax==0.4.0"
end
execute "install flake8 via pip" do
  command "pip2 install flake8==2.1.0"
end
execute "install pep8 via pip" do
  command "pip2 install pep8==1.5.6"
end
execute "install pyflakes via pip" do
  command "pip2 install pyflakes==0.8.1"
end
execute "install coveralls via pip" do
  command "pip2 install coveralls==0.4.2"
end
