# -*- mode: ruby -*-
# vi: set ft=ruby :

sshportPoint = "200"
Vagrant.configure("2") do |antjen|
  antjen.vm.box = "ubuntu/xenial64"
  antjen.vm.define "antjenkins" do |antjenkins|
    antjenkins.vm.network :private_network, ip: "10.100.1.201"
    antjenkins.vm.hostname = "antjenkins"
    antjenkins.ssh.forward_agent = true
    antjenkins.vm.network :forwarded_port, guest: 22, host: "#{sshportPoint}21", id: "ssh"
    antjenkins.vm.provider :virtualbox do |v1|
      v1.customize ["modifyvm", :id, "--memory", 1024]
      v1.customize ["modifyvm", :id, "--name", "antjenkins"]
    end
    antjenkins.vm.provision "shell", path: "scripts/install.sh"
  end
end
