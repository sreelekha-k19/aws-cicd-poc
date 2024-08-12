FROM nginx

EXPOSE 80

COPY * /usr/share/nginx/html/
COPY img /usr/share/nginx/html/img
