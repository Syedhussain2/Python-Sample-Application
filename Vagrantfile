required_plugins = %w( vagrant-hostsupdater vagrant-berkshelf )
required_plugins.each do |plugin|
  exec "vagrant plugin install #{plugin};vagrant #{ARGV.join(" ")}" unless Vagrant.has_plugin? plugin || ARGV[0] == 'plugin'
end

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

  config.vm.define "nginx-cookbook" do |nginx|
    nginx.vm.box = "ubuntu/xenial64"
    nginx.vm.provision "chef_solo" do |chef|
      chef.add_recipe "nginx-cookbook::default"
    end
  end
  

end
