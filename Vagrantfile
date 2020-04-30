# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"
  config.vm.box_check_update = false

  config.vm.network "private_network", ip: "10.20.30.10"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.cpus = 2
    vb.default_nic_type = "virtio"
  end

  config.vm.provision "00-bootstrap", type: "shell", inline: <<-SHELL
    apt-get update
    apt-get install -y docker.io docker-compose
  SHELL

  config.vm.provision "10-docker-compose", type: "shell", "run": "always", inline: <<-SHELL
    cd /vagrant
    docker-compose build
  SHELL
end
