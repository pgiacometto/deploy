FROM ubuntu:16.04

MAINTAINER Pedro Giacometto pedro.giacometto@gimalca.com

RUN apt-get update
RUN apt-get install -y curl
RUN apt-get install -y wget
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash
RUN apt-get install -y nodejs build-essential
RUN nodejs -v
RUN npm -v
RUN apt-get update
RUN apt-get install -y nginx
RUN apt-get install -y php7.0-fpm
# Latest Ubuntu Firefox, Google Chrome, XVFB and JRE installs

#========================
# Miscellaneous packages
# Includes minimal runtime used for executing non GUI Java programs
#========================
RUN apt-get -qqy update \
  && apt-get -qqy --no-install-recommends install \
    bzip2 \
    ca-certificates \
    openjdk-8-jre-headless \
    tzdata \
    sudo \
    unzip \
    wget \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/* \
  && sed -i 's/securerandom\.source=file:\/dev\/random/securerandom\.source=file:\/dev\/urandom/' ./usr/lib/jvm/java-8-openjdk-amd64/jre/lib/security/java.security

#========================================
# Add normal user with passwordless sudo
#========================================
RUN useradd seluser \
         --shell /bin/bash  \
         --create-home \
  && usermod -a -G sudo seluser \
  && echo 'ALL ALL = (ALL) NOPASSWD: ALL' >> /etc/sudoers \
  && echo 'seluser:secret' | chpasswd

#===================================================
# Run the following commands as non-privileged user
#===================================================
USER seluser

#==========
# Selenium
#==========
RUN  sudo mkdir -p /opt/selenium \
  && sudo chown seluser:seluser /opt/selenium \
  && wget --no-verbose https://selenium-release.storage.googleapis.com/3.8/selenium-server-standalone-3.8.1.jar \
    -O /opt/selenium/selenium-server-standalone.jar


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
# RUN ls
RUN npm install



COPY ./docker/docker-run.sh /docker-run.sh
EXPOSE 80 8080 4444

CMD ["/bin/bash", "docker-run.sh"]
