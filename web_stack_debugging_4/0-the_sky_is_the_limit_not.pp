#increase the ULIMIT
exec { 'fix--for-nginx':
#modify the ULIMIT value
    command => '/bin/sed -i "s/15/4096/" /etc/default/nginx',
    #specific
    path    => '/usr/local/bin/:/bin/',
}

restart
exec { 'nginx-restart':
    #restart Nginx
    command => '/etc/init.d/nginx restart'
    #specific 
    path    => '/etc/init.d'/,
}
