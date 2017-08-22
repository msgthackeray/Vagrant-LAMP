# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # Requires Virtualbox
  config.vm.box = "ubuntu/xenial64"

  config.vm.box_check_update = true

  config.vm.network "forwarded_port", guest: 80, host: 3480
  config.vm.network "forwarded_port", guest: 3306, host: 3306
  config.vm.network "forwarded_port", guest: 22, host: 2222

  config.vm.network "private_network", ip: "10.0.34.5"

  # www and apache conf
  config.vm.synced_folder "www/", "/var/www"
  config.vm.synced_folder "sites-available/", "/etc/apache2/sites-available"

  config.vm.provider "virtualbox" do |vb|
      vb.gui = true
      vb.name = "lamp-dev"
      vb.memory = "4096"
      vb.cpus = 2
  end

  config.vm.provision "shell" do |shrun|
    shrun.path = ".provision/bootstrap.sh"
  end
end
