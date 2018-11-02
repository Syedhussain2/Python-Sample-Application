required_plugins = %w( vagrant-hostsupdater vagrant-berkshelf )
required_plugins.each do |plugin|
  exec "vagrant plugin install #{plugin};vagrant #{ARGV.join(" ")}" unless Vagrant.has_plugin? plugin || ARGV[0] == 'plugin'
end


Vagrant.configure("2") do |config|

  config.vm.box = "base"
# ================================ALTER CONFIG NAMES===========================================
  config.vm.define "db" do |db|
  db.vm.box = "ubuntu/xenial64"
end

end
