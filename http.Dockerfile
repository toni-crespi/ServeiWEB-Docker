FROM ubuntu:24.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y && \
    apt-get install apache2 -y && \
    apt-get clean
RUN mkdir -p /var/www/botson/logs \
    /srv/www/botson/imatges
RUN chown -R www-data:www-data /var/www/botson \
    /srv/www/botson
COPY botson.conf /etc/apache2/sites-available/botson.conf
RUN a2dissite 000-default.conf && \
    a2ensite botson.conf && \
    a2enmod rewrite
EXPOSE 80
CMD ["apachectl", "-D", "FOREGROUND"]