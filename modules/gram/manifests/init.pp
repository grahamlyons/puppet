class gram {

    group { 'gram':
        ensure  => present,
        gid     => 1021
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
        key     => 'AAAAB3NzaC1yc2EAAAABIwAAAQEAyB+eGBdlit/waWwsnkarYVNAEIXbsEKJmgTnNX5QWMOsEYjgmUc2pbEq/eaclMiw4KsR7VK9i15CojewM+g9X7qyu2OEETsXmQM3z+yops/SYDU8o/YKBNn+VWiyObxQwWghDsmcNAufhpF2A1fU8YGeNJxPG8/LvPnAGh3iku3MPOytykETVuzznGQqkgBRqKYOtM69meeOHRZNquYRITB0qsg22iDrYEbmCKoKyBKj1E80OwrT/DAEcLICXMGeIVgkMEDc7qqaxFHfTN8MW8T2jmASMI49pKDKc0AtLvRu0l3VcWjV/B9WilcEvsZkYzjw6a9nuJiwxgjIhFB3OQ==',
        user    => 'gram',
        type    => 'rsa'
    }
}
