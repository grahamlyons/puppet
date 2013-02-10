class mysite {

    file { '/var/apps/': 
        ensure  => directory,
        mode    => '0700'
    }

    exec { 'app-init':
        command => 'git clone https://github.com/grahamlyons/mysite.py.git mysite',
        cwd     => '/var/apps/',
        logoutput   => on_failure,
        require     => [Package['git'], File['/var/apps/']],
        creates     => '/var/apps/mysite/.git'
    }

    file { '/etc/supervisor/conf.d/mysite.conf':
        source  => 'puppet:///modules/mysite/supervisor_config',
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        notify  => Service['supervisor']
    }

}
