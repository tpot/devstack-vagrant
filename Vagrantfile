# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/trusty64"
  config.vm.provision "shell", path: "provision.sh", privileged: false

  config.vm.provider "virtualbox" do |v|
    v.memory = 4096
    v.cpus = 2
  end

  # Port forwarding for OpenStack services
  [35357, 5000, 8774, 8776, 9696, 9191, 9292, 6080, 8080, 80].each do |port|
    config.vm.network "forwarded_port", guest: port, host: port, protocol: 'tcp'
  end

  if Vagrant.has_plugin?("vagrant-proxyconf")
    config.proxy.http     = ENV["http_proxy"]
    config.proxy.https    = ENV["https_proxy"]
    config.proxy.no_proxy = "10.0.2.15,#{ENV["no_proxy"]}"
  end

end
