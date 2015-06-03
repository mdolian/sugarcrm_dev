FROM php:5.6-apache

ENV MAJOR_VERSION 6.5
ENV MINOR_VERSION 20
ENV SOURCEFORGE_MIRROR http://softlayer-dal.dl.sourceforge.net
ENV WWW_FOLDER /var/www/html

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y libcurl4-gnutls-dev libpng-dev unzip cron re2c php5-imap python

RUN docker-php-ext-install mysql curl gd zip mbstring

WORKDIR /tmp

ADD config_override.php.pyt /usr/local/src/config_override.php.pyt
ADD envtemplate.py /usr/local/bin/envtemplate.py
ADD init.sh /usr/local/bin/init.sh

RUN chmod u+x /usr/local/bin/init.sh

ADD crons.conf /root/crons.conf
RUN crontab /root/crons.conf

EXPOSE 80
ENTRYPOINT ["/usr/local/bin/init.sh"]
