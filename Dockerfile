FROM ubuntu:20.04

MAINTAINER Yanek Goodman <yanekgoodman@protonmail.com>
LABEL This Docker Is Tested On Ubuntu 16.04,18.04,20.04 But Should Work On Others!

ENV TZ America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
EXPOSE 80
EXPOSE 443


RUN apt-get update
RUN apt-get install -y nano
RUN apt-get install -y apache2 php php-dom php-curl curl composer zip unzip && rm -rf /var/lib/apt/lists/*
ENV APACHE_RUN_USER  www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_PID_FILE  /var/run/apache2/apache2.pid
RUN a2enmod ssl
run a2ensite default-ssl.conf
RUN mkdir -p /var/run/apache2
RUN mkdir -p /var/lock/apache2
RUN mkdir -p /var/log/apache2
CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]

RUN rm -rf /var/www/html/*
RUN composer create-project athlon1600/php-proxy-app:dev-master /var/www/html
RUN chown -R www-data:www-data /var/www/html
LABEL Give About 30sec Before Acessing Webpage
