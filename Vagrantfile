# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.hostname = "analytics-kitchen"

  config.vm.network :private_network, ip: "192.168.50.31"

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", 2048]
    vb.customize ["modifyvm", :id, "--cpus", 2]
  end

  config.omnibus.chef_version = :latest

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "./site-cookbooks"
    chef.log_level = :debug

    chef.environments_path = "./environments"
    chef.environment = "local"

    chef.json = {
      :nginx => {
        :port => 80
      },
      :rbenv => {
        :user => "vagrant",
        :version => "2.2.0"
      }
    }
    chef.add_recipe("dev-tools")
    chef.add_recipe("nginx")
    chef.add_recipe("rbenv")
    chef.add_recipe("oracle-java")
  end
end
