backend mysite {
    .host = "127.0.0.1";
    .port = "8080";
}

sub vcl_recv {
    if (req.http.host ~ "(^|.)grahamlyons.com$") {
        set req.backend = mysite;
    } else {
        error 403 "Unauthorised";
    }
}

sub vcl_deliver {
    unset resp.http.X-Varnish;
    unset resp.http.Via;
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
