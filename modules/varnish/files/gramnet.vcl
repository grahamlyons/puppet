backend mysite {
    .host = "127.0.0.1";
    .port = "8080";
}

sub vcl_recv {
    if (req.http.host ~ ".grahamlyons.com$") {
        set req.backend = mysite;
    } else {
        error 403 "Unauthorised";
    }
}

sub vcl_deliver {
    unset resp.http.X-Varnish;
    unset resp.http.Via;
}
