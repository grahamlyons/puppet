backend mysite {
    .host = "127.0.0.1";
    .port = "8080";
}

sub vcl_recv {
    if (req.http.host ~ "(^|.)grahamlyons.com$") {
        set req.backend = mysite;
        // No cookies or auth used and default VCL passes when they're present
        unset req.http.Cookie;
        unset req.http.Authorisation;
    } else {
        error 403 "Unauthorised";
    }
}

sub vcl_hit {
    set req.http.X-Cache-Action = "HIT";
}

sub vcl_miss {
    set req.http.X-Cache-Action = "MISS";
}

sub vcl_pass {
    set req.http.X-Cache-Action = "PASS";
}

sub vcl_deliver {
    set resp.http.X-Cache-Age = resp.http.Age;
    set resp.http.X-Cache-Action = req.http.X-Cache-Action;
    set resp.http.X-Cache-Hits = obj.hits;

    set resp.http.Server = regsub(resp.http.Server, "^(\w+)/.+$", "\1");

    unset resp.http.X-Varnish;
    unset resp.http.Via;
    unset resp.http.Age;
}

sub vcl_error {
   set obj.http.Content-Type = "text/html; charset=utf-8";
   set obj.http.Retry-After = "5";
   synthetic {"
<!DOCTYPE HTML>
<html>
    <head>
        <title>"} + obj.status + " " + obj.response + {"</title>
        <style type="text/css">
        body {
            font-family: sans-serif;
            background-color: #DDD;            
        }
        </style>
    </head>
    <body>
        <h1>Error "} + obj.status + " " + obj.response + {"</h1>
    </body>
</html>
"};
   return (deliver);
}
