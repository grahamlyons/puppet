define webapp($port) {

    include webapp::approot

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

    file { "/var/apps/$name/newrelic.ini":
        content => template("webapp/newrelic.ini.erb"),
        owner   => "root",
        group   => "root",
        mode    => "0644",
        require => [Package["newrelic"], Exec["app-init $name"]]
    }

    file { "/etc/supervisor/conf.d/$name.conf":
        content => template("webapp/supervisor_config.erb"),
        owner   => "root",
        group   => "root",
        mode    => "0644",
        require => [Package["supervisor"], Exec["app-update $name"], File[ "/var/apps/$name/newrelic.ini"]],
        notify  => Service["supervisor"]
    }

}
