class loggly {

    package { 'rsyslog':
        ensure => latest
    }

    file { '/etc/rsyslog.d/loggly.conf':
        content => '*.*    @@logs.loggly.com:28319',
        owner   => 'root',
        group   => 'root',
        mode    => '644',
        require => Package['rsyslog'],
        notify  => Service['rsyslog']
    }

    service { 'rsyslog':
        ensure  => running
    }
}

