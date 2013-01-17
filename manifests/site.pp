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
}

node /^gramdev\d*/ inherits default {
    include dev-tools
    include python-web
    include varnish
    include mysite
    include git
}

node /^gramnet\d*/ inherits default {
    include python-web
    include varnish
}
