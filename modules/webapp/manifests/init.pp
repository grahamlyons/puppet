class webapp($name) {

    file { "/var/apps/": 
        ensure  => directory,
        mode    => "0755"
    }

    exec { "app-init $name":
        command => "git clone https://github.com/grahamlyons/$name.git $name",
        cwd     => "/var/apps/",
        logoutput   => on_failure,
        require     => [Package["git"], File["/var/apps/"]],
        creates     => "/var/apps/$name/.git"
    }

    exec { "app-update $name":
        command => "git pull",
        cwd     => "/var/apps/$name",
        logoutput   => on_failure,
        require     => [Package["git"], Exec["app-init $name"]],
    }

    file { "/etc/supervisor/conf.d/$name.conf":
        content => template("webapp/supervisor_config.erb"),
        owner   => "root",
        group   => "root",
        mode    => "0644",
        require => [Package["supervisor"], Exec["app-update $name"]],
        notify  => Service["supervisor"]
    }

}
