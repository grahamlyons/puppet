class vim {

    package { 'vim':
        ensure => latest
    }

    file { '/home/gram/.vimrc':
        source => 'puppet:///modules/vim/vimrc',
        owner   => 'gram',
        group   => 'gram',
        mode    => '640'
    }
}
