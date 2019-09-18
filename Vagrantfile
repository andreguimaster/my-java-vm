Vagrant.configure("2") do |config|
	config.vm.box = "bento/ubuntu-18.04"
	
	config.vm.define :java2 do |java_config|
		java_config.vm.network "forwarded_port", guest: 8080, host: 8081
		java_config.vm.provision "shell", inline: "sudo apt-get update && sudo apt-get install -y puppet"
		
		java_config.vm.provision "puppet" do |puppet|
			puppet.manifest_file = "java.pp"
		end

		java_config.vm.provision :reload
	end

	# Habilita interface gráfica, configura memória, define número de cpus e configura o proxy
	config.vm.provider :virtualbox do |vb|
        vb.gui = true
        vb.memory = 10240
        vb.cpus = 5

		vb.customize ["modifyvm", :id, "--vram", "256"]
		vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    	vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    end
end