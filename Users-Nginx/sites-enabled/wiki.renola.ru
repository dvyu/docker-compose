    server {
        listen 80;
        server_name wiki.renola.ru;

        location / {
            proxy_pass http://127.0.0.1:8080
            include /etc/nginx/include-static/commonheaders; 
        }
    }
