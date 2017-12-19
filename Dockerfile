FROM ubuntu:16.04

MAINTAINER Pedro Giacometto pedro.giacometto@gimalca.com

RUN apt-get update
RUN apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash
RUN apt-get install -y nodejs build-essential
RUN nodejs -v
RUN npm -v
RUN apt-get update
RUN apt-get install -y nginx
RUN apt-get install -y php7.0-fpm
# Remove the default Nginx configuration file

# Remove the default Nginx configuration file
RUN rm -v /etc/nginx/nginx.conf
RUN rm -v /etc/nginx/sites-available/default

# Copy a configuration file from the current directory
ADD ./docker/nginx.conf /etc/nginx/
ADD ./docker/default /etc/nginx/sites-available/
# Append "daemon off;" to the beginning of the configuration
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# Copy a configuration file from the current directory
ADD ./  /var/www/html/

WORKDIR /var/www/html/
RUN ls
RUN npm install

# Latest Ubuntu Firefox, Google Chrome, XVFB and JRE installs
RUN apt-get update -qqy \
  && apt-get -qqy install \
    xvfb \
    firefox=45.0.2+build1-0ubuntu1 \
    default-jre

COPY ./docker/docker-run.sh /docker-run.sh
EXPOSE 80

CMD ["/bin/bash", "docker-run.sh"]
