class updates {

    package {'unattended-upgrades':
        ensure  => latest
    }

    file {'/etc/apt/apt.conf.d/10periodic':
        source  => 'puppet:///modules/updates/10periodic',
        require => Package['unattended-upgrades']
    }

    file {'/etc/cron.daily/puppet-update':
        source  => 'puppet:///modules/updates/puppet-update',
        require => Package['git']
    }
}
