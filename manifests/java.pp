exec { "add-java-repo":
	command => "sudo add-apt-repository -y ppa:openjdk-r/ppa",
	path => "/usr/bin"
}

exec { "apt-key-update":
	command => "sudo apt-key update",
	path => "/usr/bin",
	require => Exec["add-java-repo"]
}

exec { "apt-update":
	command => "sudo apt-get update",
	path => "/usr/bin",
	require => Exec["apt-key-update"]
}

package { ["ubuntu-desktop"]:
    ensure => present,
    require => Exec["apt-update"]
}

package { ["virtualbox-guest-utils","virtualbox-guest-dkms"]:
    ensure => present,
    require => Package["ubuntu-desktop"]
}

package { ["ubuntu-restricted-extras"]:
    ensure => present,
    require => Exec["apt-update"]
}

package { ["openjdk-11-jdk"]:
    ensure => present,
    require => Exec["apt-update"]
}

package { ["maven"]:
    ensure => present,
    require => Package["openjdk-11-jdk"]
}

package { ["git"]:
    ensure => present,
    require => Exec["apt-update"]
}

package { ["snapd"]:
    ensure => present,
    require => Exec["apt-update"]
}

exec { "eclipse":
	command => "sudo snap install eclipse --classic",
	path => "/usr/bin",
	require => Package["snapd"]
}

exec { "add-cpg-docker-key":
	command => "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -",
	path => "/usr/bin"
}

exec { "add-docker-repo":
	command => "sudo add-apt-repository \"deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable && sudo apt-get update\"",
	path => "/usr/bin",
	require => Exec["add-cpg-docker-key"]
}

package { ["docker-ce"]:
    ensure => present,
    require => Exec["add-docker-repo"]
}

