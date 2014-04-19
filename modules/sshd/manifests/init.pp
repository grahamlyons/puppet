define sshd($users) {

    package { 'openssh-server':
        ensure => latest
    }

    file { '/etc/ssh/sshd_config':
        ensure  => present,
        content => template('sshd/sshd_config.erb'),
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        require => Package['openssh-server'],
        notify  => Service['ssh']
    }

    service { 'ssh':
        ensure      => running,
        hasstatus   => true,
        hasrestart  => true,
        enable      => true,
        require     => File['/etc/ssh/sshd_config']
    }

}
