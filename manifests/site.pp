Firewall {
    notify  => Exec['persist-firewall'],
    require => Exec['purge default firewall'],
}

Exec { path => '/usr/bin:/bin:/usr/sbin:/sbin' }

node default {
    include gram
    include firewall
    include vim
    include newrelic
    include loggly
    include updates
}

node /^gramdev\d*/ inherits default {
    sshd {'dev':
        users => 'gram vagrant'
    }
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
    sshd {'prod':
        users => 'gram'
    }
    webapp {'mysite':
        port => 8080
    }
    webapp {'localplaques':
        port => 8081
    }
}
