# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    USER="ansiblewordpress"
    PASSWORD="mypassword"
    WORDPRESS_IP="192.168.0.1"
    MYSQL_IP="192.168.0.2"
    ANSIBLE_IP="192.168.0.10"

    # wordpress worker
    config.vm.define "wordpress" do |wordpress|
        wordpress.vm.box = "debian/buster64"
        wordpress.vm.network "private_network", ip: WORDPRESS_IP, netmask: 24, virtualbox__intnet: true
        wordpress.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
        wordpress.vm.provider "virtualbox" do |vb|
            vb.name = "wordpress"
            vb.gui = false
            vb.memory = "512"
            vb.cpus = 1
        end
        wordpress.vm.provision "shell", path: "./scripts/worker.sh", args: [USER, PASSWORD]
    end

    # mysql worker
    config.vm.define "mysql" do |mysql|
        mysql.vm.box = "debian/buster64"
        mysql.vm.network "private_network", ip: MYSQL_IP, netmask: 24, virtualbox__intnet: true
        mysql.vm.provider "virtualbox" do |vb|
            vb.name = "mysql"
            vb.gui = false
            vb.memory = "512"
            vb.cpus = 1
        end
        mysql.vm.provision "shell", path: "./scripts/worker.sh", args: [USER, PASSWORD]
    end
    
    # ansible controller
    config.vm.define "ansible" do |ansible|
        ansible.vm.box = "debian/buster64"
        ansible.vm.hostname = "ansible"
        ansible.vm.network "private_network", ip: ANSIBLE_IP, netmask: 24, virtualbox__intnet: true
        ansible.vm.provider "virtualbox" do |vb|
            vb.name = "ansible"
            vb.gui = false
            vb.memory = "512"
            vb.cpus = 1
        end
        ansible.vm.provision "file", source: "./ansible", destination: "/tmp/ansible", run: "always"
        ansible.vm.provision "shell" do |shell|
            shell.path = "./scripts/controller.sh"
            shell.args = [USER, PASSWORD, WORDPRESS_IP, MYSQL_IP]
        end
    end
end 
