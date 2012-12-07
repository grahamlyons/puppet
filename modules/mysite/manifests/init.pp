class mysite {

    file { '/var/apps/': 
        ensure  => directory,
        owner   => 'gram',
        group   => 'gram',
        mode    => '0700'
    }

    file { '/var/apps/mysite/': 
        ensure  => directory,
        owner   => 'git',
        group   => 'git',
        mode    => '0700'
    }

    exec { 'app-init':
        command => 'git clone git@bitbucket.org:grahamlyons/puppet.git',
        cwd     => '/var/apps/mysite/',
        user    => 'git',
        logoutput   => on_failure,
        requires    => Package['git'],
        requires    => File['/var/apps/mysite/'],
        creates     => '/var/apps/mysite/.git'
    }

    file { '/etc/supervisor.d/mysite',
        source  => 'puppet:///modules/mysite/supervisor_config',
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        notify  => Service['supervisor']
    }

}
