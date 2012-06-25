# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.box = "fedora-16"
  # config.vm.box_url = "http://domain.com/path/to/above.box"

  config.vm.customize do |vm|
    vm.memory_size = 1024
  end

  config.vm.host_name = "oucxdev"
  config.vm.network :hostonly, "10.24.7.86"

  config.vm.share_folder "bin", "/home/vagrant/bin", "bin", :create => true, :nfs => true
  config.vm.share_folder "conf", "/home/vagrant/conf", "conf", :create => true, :nfs => true
  
  config.vm.share_folder "openacd", "/home/vagrant/workspace/openacd", "OpenACD", :create => true, :nfs => true
  config.vm.share_folder "sipxecs", "/home/vagrant/workspace/sipxecs", "sipxecs", :create => true, :nfs => true
  config.vm.share_folder "oucxweb", "/home/vagrant/workspace/oucxweb", "oucXopenacdWeb", :create => true, :nfs => true

  config.vm.forward_port 80, 7080 # Apache
  config.vm.forward_port 9000, 7090 # Play
  config.vm.forward_port 5050, 7050 # OpenACD Agent
  config.vm.forward_port 9999, 7099 # OpenACD Admin


  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests"
    puppet.manifest_file  = "base.pp"
  end
end
