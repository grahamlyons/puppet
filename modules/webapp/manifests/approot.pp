class webapp::approot {

    file { "/var/apps/": 
        ensure  => directory,
        mode    => "0755"
    }

}
