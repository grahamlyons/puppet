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
        key     => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDE4XY0pTIhb8FskbF+eTp9bWD3jO1lHFAae2nnTzE3/jE1kQ950xrrT3BcPBVb+NQVfP7uWahMxTSFCfWNaWAADUO9SKdVhbc7aogSmkk3wIcaY7O3qpOFVtAvrtJEhunyiJI5NSC3C8iWUkvZe6JlkKSXHJX4j8BE52QRJwczHfBlkrVHO8rUttNtVGq72YBMvMP0x9Sz0KsQhqrFuXXx9eZbnDitrx9QfM2B6EcV/wL6b6IhWc51V2A9U3qsfEu3hEU2hETTO9mQ439RsgOIYaFfDsCdMrw/f+vbJlvJ6o+6/OSK70M/sL6XySAEr9b9XKLJ1kGZkd6UeRGxFsYv',
        user    => 'gram',
        type    => 'rsa'
    }
}
