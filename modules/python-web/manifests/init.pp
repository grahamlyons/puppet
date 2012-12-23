class python-web {

    package { 'python-pip':
        ensure  => latest
    }

    package { 'PyYAML':
        provider  => pip,
        ensure  => latest,
        require => Package['python-pip']
    }

    package { 'markdown2':
        provider  => pip,
        ensure  => latest,
        require => Package['python-pip']
    }
    package { 'flask':
        provider  => pip,
        ensure  => latest,
        require => Package['python-pip']
    }

    package { 'jinja2':
        provider  => pip,
        ensure  => latest,
        require => Package['python-pip']
    }

    package { 'gunicorn':
        provider  => pip,
        ensure  => latest,
        require => Package['python-pip']
    }

    package { 'supervisor':
        ensure  => latest
    }

    service { 'supervisor':
        name    => 'supervisor',
        ensure  => running,
        enable  => true,
        hasrestart  => true,
        require => Package['supervisor']
    }

}
