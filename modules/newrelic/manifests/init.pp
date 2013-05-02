class newrelic {

    file { '/etc/apt/sources.list.d/newrelic.list':
        ensure  => present,
        source  => 'puppet:///modules/newrelic/newrelic.list',
        notify  => Exec['newrelic-key']
    }

    exec { 'newrelic-key':
        command => 'apt-key adv --keyserver hkp://subkeys.pgp.net --recv-keys 548C16BF',
        onlyif  => 'apt-key list | grep -v 548C16BF 1> /dev/null',
        subscribe   => File['/etc/apt/sources.list.d/newrelic.list'],
        refreshonly => true
    }

    exec { 'apt-get update':
        require => Exec['newrelic-key']
    }

    package { 'newrelic-sysmond':
        ensure => latest,
        require => [Exec['apt-get update'], File['/etc/apt/sources.list.d/newrelic.list']],
        notify  => Exec['set-license-key']
    }

    exec { 'set-license-key':
        command => 'nrsysmond-config --set license_key=847b18545ec8880e445bc338a52c70b286d96a4a',
        subscribe => Package['newrelic-sysmond'],
        notify  => Service['newrelic-sysmond']
    }

    service { 'newrelic-sysmond':
        hasrestart => false,
        ensure  => running
    }

    package { 'newrelic':
        provider => pip,
        ensure => latest,
        require => Package['python-pip']
    }

}
