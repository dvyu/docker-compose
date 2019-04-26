    server {
        listen 443 ssl;
        server_name ssl.example.com;
        ssl_certificate      /etc/nginx/certs/serverx.crt;
        ssl_certificate_key  /etc/nginx/certs/serverx.key;
        ssl_client_certificate /etc/nginx/certs/ca.crt;
        ssl_verify_client on;

        location / {
            if ($admin_allow_user){return 403;}
            proxy_pass http://172.16.0.8:3340;
            include /etc/nginx/include-static/commonheaders;
        }

    }
