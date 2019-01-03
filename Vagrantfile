# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define "kube1.node" do |config|
    config.vm.box = "generic/ubuntu1804"
    config.vm.network :private_network, ip: "192.168.70.10"
    config.vm.provider :libvirt do |vb|
      vb.cpus = 2
      vb.memory = 4096
    end
    config.vm.hostname = "kube1.node"
    config.vm.synced_folder './', '/vagrant', type: 'rsync'
    config.vm.provision :shell, inline: <<-SHELL
      set -eux
      export DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true
      rm -rf /etc/resolv.conf
      echo "nameserver 8.8.8.8" > /etc/resolv.conf
      apt-get update
      apt-get dist-upgrade -y
      # NOTE: change me to "calico" to change to calico cni
      export DEFAULT_CNI="flannel"
      cd /vagrant; time bash scripts/master.sh
    SHELL
  end
end
