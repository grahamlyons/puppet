class dev-tools {

    package {'make':
        ensure => latest
    }

    package {'gcc':
        ensure => latest
    }

    package { 'man':
        ensure => latest
    }

}
