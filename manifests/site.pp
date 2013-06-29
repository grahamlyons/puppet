Firewall {
    notify  => Exec['persist-firewall'],
    require => Exec['purge default firewall'],
}

Exec { path => '/usr/bin:/bin:/usr/sbin:/sbin' }

node default {
    include gram
    include firewall
    include vim
    include sshd
    include newrelic
    include loggly
    include updates
}

node /^gramdev\d*/ inherits default {
    include screen
    include dev-tools
    include python-web
    include varnish
    include git
    include nodejs
}

node /^gramnet\d*/ inherits default {
    include python-web
    include varnish
    include git
    webapp {'mysite':
        port => 8080
    }
    webapp {'localplaques':
        port => 8081
    }
}
