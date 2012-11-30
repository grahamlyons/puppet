class dev-tools {

    package {'make':
        ensure => latest
    }

    package {'gcc':
        ensure => latest
    }

    package { 'man':
        ensure => latest
    }

    firewall { '100 allow flask dev port':
        state => ['NEW'],
        dport => '5000',
        proto => 'tcp',
        action  => 'accept',
    }
    
}
