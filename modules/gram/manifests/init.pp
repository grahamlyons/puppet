class gram {

    group { 'gram':
        ensure  => present,
        gid     => 1000
    }

    user { 'gram':
        ensure      => present,
        uid         => 1000, 
        gid         => 'gram',
        shell       => '/bin/bash',
        home        => '/home/gram',
        managehome  => true,
        # Randomly generated
        password    => '$6$f006dbfc501093f2$K1u1z9rke12af4VFu4nWZyubm5r3jjgMakhOBJYg22mSUTfdd1NiCIeHf7ZlQgtSi92hJxiRmqTs5KdYeu1dr.',
        require     => Group['gram']
    }

    package { 'sudo':
        ensure => latest
    }

    file { 'sudoers':
        source  => 'puppet:///modules/gram/gram',
        path    => '/etc/sudoers.d/gram',
        owner   => 'root',
        group   => 'root',
        mode    => '440',
        require => Package['sudo']
    }

    ssh_authorized_key { 'gram':
        ensure  => present,
        key     => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCxyYmS7YJimE3wqmbZpB7uHmVPWWrMj1+xDfnb4/RmYk47xQgb9gx5NqMiD59IYhwCYB8RVTv+m7uQBWXd0PZ7z3ZnbQQndh+mDaSrI6RsHBYrUTQpkeJYCE8WWceCyyV3HiBnAh2nIx1fldUsaTXnWqV93alpYv+Cj6lVuqtcRXK16KqXSE849EfFXEyAfu7kQPdgLIWOEwxEWrO2wEbI2WijGd13bKQVNCQsACBXRXiKaG7TN9JncjQFmkKTk8fEp/7EyVrFp9JhyS3rbVtE2INZvfGXbB5hQVJN4kRnR5kVWDcde+4xxEpMDQlUT1Cuihg46PcGwWrgZddDHy+z',
        user    => 'gram',
        type    => 'rsa'
    }
}
