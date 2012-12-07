class git {

    package { 'git':
        ensure => latest
    }

    user { 'git':
        ensure  => present,
        home    => '/home/git/',
        managehome  => true,
        uid     => 510
    }

    file { '/home/git/.ssh/config':
        source  => 'puppet:///modules/git/ssh_config',
        owner   => 'git'
        group   => 'git'
        mode    => '0644'
    }
}
