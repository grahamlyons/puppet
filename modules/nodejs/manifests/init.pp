class nodejs {

    exec { 'add-node-repo':
        command => 'add-apt-repository ppa:chris-lea/node.js -y && apt-get update',
        creates => '/etc/apt/sources.list.d/chris-lea-node_js-precise.list'
    }

    package{ 'nodejs':
        ensure  => latest,
        require => Exec['add-node-repo']
    }

}
