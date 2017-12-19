FROM ubuntu:16.04

MAINTAINER Pedro Giacometto pedro.giacometto@gimalca.com

RUN apt-get update
RUN apt-get install -y nodejs
RUN apt-get update
RUN apt-get install -y npm
RUN apt-get install -y nginx
RUN apt-get install -y php7.0-fpm
# Remove the default Nginx configuration file

# Remove the default Nginx configuration file
RUN rm -v /etc/nginx/nginx.conf
RUN rm -v /etc/nginx/sites-available/default
# Copy a configuration file from the current directory
ADD ./docker/nginx.conf /etc/nginx/
ADD ./docker/default /etc/nginx/sites-available/

# Copy a configuration file from the current directory
ADD ./dist/  /var/www/html/

# Append "daemon off;" to the beginning of the configuration
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

COPY ./docker/docker-run.sh /docker-run.sh
EXPOSE 80

CMD ["/bin/bash", "docker-run.sh"]
