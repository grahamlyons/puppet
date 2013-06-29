class updates {

    package {'unattended-upgrades':
        ensure  => latest
    }

    file {'/etc/apt/apt.conf.d/10periodic':
        source  => 'puppet:///modules/updates/10periodic',
        require => Package['unattended-upgrades']
    }

}
