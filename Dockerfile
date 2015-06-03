FROM jarias/apache2

RUN apt-get update && apt-get upgrade -y && \
	apt-get install -y php5-mysql php5-imap php5-curl php5-gd curl unzip cron && \
	curl -O "http://softlayer-dal.dl.sourceforge.net/project/sugarcrm/1%20-%20SugarCRM%206.5.X/SugarCommunityEdition-6.5.X/SugarCE-6.5.17.zip" && \
	unzip SugarCE-6.5.17.zip && \
	rm -rf /var/www/* && \
	cp -R SugarCE-Full-6.5.17/* /var/www/ && \
	chown -R www-data:www-data /var/www/* && \
	chown -R www-data:www-data /var/www && \
	sed -i 's/^upload_max_filesize = 2M$/upload_max_filesize = 10M/' /etc/php5/apache2/php.ini

ADD init.sh /usr/local/bin/init.sh

ADD crons.conf /root/crons.conf
RUN crontab /root/crons.conf

EXPOSE 80
ENTRYPOINT ["/usr/local/bin/init.sh"]
