FROM nginx:latest
COPY index.html /usr/share/nginx/html/index.html
EXPOSE 8081
CMD ["nginx", "-g", "daemon off;", "-c", "/etc/nginx/nginx.conf", "-g", "pid /var/run/nginx.pid;"]
