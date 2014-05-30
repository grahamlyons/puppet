class gram {

    group { 'gram':
        ensure  => present,
        gid     => 1021
    }

    user { 'gram':
        ensure      => present,
        uid         => 1021, 
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
    
    ssh_authorized_key { 'gram-shutl':
        ensure  => present,
        key     => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCoodO22zn++OuPmiJgkeGg3AT+29Mt9shdhqjTlMfPTMEQEtT9hvk47ZV6+URgdwo2Rd81mLTcJr86q+dnDSdB8T/hXj4lf1UL30nS0oSbS+KkHtWBcORUyZi49hFsWhd7aYKB9esIUt7IS+H8qwsLIT7/O79+8gy43lx7HCigyh5WZmuZf00aOMl6Vf1Sm99WAWjJPPYGu/HWtDrMvzUZyMk9o4cgWnheV8BGqWoOnE5wWZKKcPZR7UGsvWIvo/8VbzRdYHrzy1qUb/GXxEboHlj71b5xnrGL618RtzFNtXVKrekU3Xy8ucRWQHPIkgz+Xh8MbgSRE772gVnCTsrV',
        user    => 'gram',
        type    => 'rsa'
    }

}
