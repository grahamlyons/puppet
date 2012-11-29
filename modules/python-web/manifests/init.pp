class python-web {

    package { "flask":
        provider  => pip
        ensure  => latest

    }
}
