# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/xenial64"

  # this cannot be done with a synced folder as you cannot change the permissions
  # on a synced folder
  config.vm.provision "shell", inline: "cp -rf /vagrant/site /home/ubuntu/site"
  config.vm.provision "shell", inline: "sudo chmod -R 400 /home/ubuntu/site"
  config.vm.provision "shell", inline: "echo 'export LC_ALL=C' >> /home/ubuntu/.bashrc"

end
