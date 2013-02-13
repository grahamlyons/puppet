class mysite {

    file { '/var/apps/': 
        ensure  => directory,
        mode    => '0755'
    }

    exec { 'app-init':
        command => 'git clone https://github.com/grahamlyons/mysite.py.git mysite',
        cwd     => '/var/apps/',
        logoutput   => on_failure,
        require     => [Package['git'], File['/var/apps/']],
        creates     => '/var/apps/mysite/.git'
    }

    exec { 'app-update':
        command => 'git pull',
        cwd     => '/var/apps/mysite',
        logoutput   => on_failure,
        require     => [Package['git'], Exec['app-init']],
    }

    file { '/etc/supervisor/conf.d/mysite.conf':
        source  => 'puppet:///modules/mysite/supervisor_config',
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        notify  => Service['supervisor']
    }

}
