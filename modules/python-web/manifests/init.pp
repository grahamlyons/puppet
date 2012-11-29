class python-web {

    package { "python-pip":
        ensure  => latest
    }

    package { "flask":
        provider  => pip,
        ensure  => latest,
        require => Package['python-pip']
    }

    package { "jinja2":
        provider  => pip,
        ensure  => latest,
        require => Package['python-pip']
    }

    package { "gunicorn":
        provider  => pip,
        ensure  => latest,
        require => Package['python-pip']
    }

    package { "supervisor":
        provider  => pip,
        ensure  => latest,
        require => Package['python-pip']
    }

}
