class varnish {

    package { 'varnish':
        ensure => latest
    }

    firewall { '100 allow http port':
        state => ['NEW'],
        dport => '80',
        proto => 'tcp',
        action  => 'accept',
    }

    service {'varnish':
        ensure      => running,
        hasstatus   => true,
        hasrestart  => true,
        enable      => true,
        require     => [File['/etc/varnish/gramnet.vcl'], File['/etc/default/varnish']]
    }

    file { '/etc/varnish/default.vcl':
        ensure  => absent,
        require => Package['varnish'],
        notify  => Service['varnish']
    }

    file { '/etc/default/varnish':
        ensure  => present,
        source  => 'puppet:///modules/varnish/startup',
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        require => Package['varnish'],
        notify  => Service['varnish']
    }

    file { '/etc/varnish/gramnet.vcl':
        ensure  => present,
        source  => 'puppet:///modules/varnish/gramnet.vcl',
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        require => Package['varnish'],
        notify  => Service['varnish']
    }
}
