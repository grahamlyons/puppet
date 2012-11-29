Firewall {
    notify  => Exec["persist-firewall"],
    require => Exec["purge default firewall"],
}

node default {
    include gram
    #include firewall
    include vim
}

node /^gramdev\d*/ inherits default {
    include dev-tools
}
