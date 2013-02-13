class screen {

    package { 'screen':
        ensure => latest
    }

    file { '/home/gram/.screenrc':
        source => 'puppet:///modules/screen/screenrc',
        owner   => 'gram',
        group   => 'gram',
        mode    => '640'
    }
}
