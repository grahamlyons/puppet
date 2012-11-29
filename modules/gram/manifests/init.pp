class gram {

    user { "gram":
        ensure     => present,
        gid        => 'gram',
        shell      => '/bin/bash',
        home       => '/home/gram',
        managehome => true
    }

    package {'sudo':
        ensure => latest
    }

    file {'sudoers':
        source  => 'puppet:///modules/gram/gram',
        path    => '/etc/sudoers.d/gram',
        owner   => 'root',
        group   => 'root',
        mode    => '440',
        require => Package['sudo']
    }

}
