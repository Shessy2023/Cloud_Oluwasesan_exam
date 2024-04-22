# -*- mode: ruby -*-
# vi: set ft=ruby :

  # First I will configure my Master server
Vagrant.configure("2") do |config|
  config.vm.define "master" do |master|
    master.vm.box = "ubuntu/focal64"
    master.vm.hostname = "master"
    master.vm.network "private_network", type: "dhcp"
    master.vm.network "forwarded_port", guest: 80, host: 8085
  end

    # Next I configure my  Slave server
  config.vm.define "slave" do |slave|
    slave.vm.box = "ubuntu/focal64"
    slave.vm.hostname = "slave"
    slave.vm.network "private_network", type: "dhcp"
    slave.vm.network "forwarded_port", guest: 80, host: 8086
  end
end


