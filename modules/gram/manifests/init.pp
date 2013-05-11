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
        key     => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQC2adBmbhD9DV8Ra4OdJZZ7+jooqPOzORj4Wg4jqfnOm5Y912XrWQQCB4baJz7XK271qCfW6IRTgJVp27jdv+qMTUEDlBvJBrJMOABny5KOEyJxtzZs3FY8v8U1iH8DVgJylPLwo1/CCk4uEbM496KfTk+pw3oHeTwNWTI8lSLuKb6KdLus6JxHI0IKHttF9AENiAiVmMk6ArBAWZduE05o3m+xfZXAKKCwRwFKaISa3yAqCNrRoZr34TfasxzesbM2kTr+pQ6X4WI9AgTi1y9QgrVmQJ6hSHztVmjWAofFEfeNjJV51BmB5wy4pW8Fd0Ead+mrwJ1JowPecNCoJuhd',
        user    => 'gram',
        type    => 'rsa'
    }
}
