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
}
