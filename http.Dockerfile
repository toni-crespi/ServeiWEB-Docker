FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Instal·lar Apache
RUN apt-get update -y && \
    apt-get install apache2 -y && \
    apt-get clean

# Crear carpetes per als dos serveis
RUN mkdir -p /var/www/botson \
    && mkdir -p /var/www/botson/logs \
    && mkdir -p /var/www/botsonorg \
    && mkdir -p /var/www/botsonorg/logs

# Assignar permisos
RUN chown -R www-data:www-data /var/www/botson /var/www/botsonorg

# Copiar els VirtualHosts
COPY botson.conf /etc/apache2/sites-available/botson.conf
COPY botsonorg.conf /etc/apache2/sites-available/botsonorg.conf

# Activar VirtualHosts i mòduls necessaris
RUN a2dissite 000-default.conf && \
    a2ensite botson.conf && \
    a2ensite botsonorg.conf && \
    a2enmod rewrite

# Exposar port HTTP
EXPOSE 80

# Arrencar Apache en primer pla
CMD ["apachectl", "-D", "FOREGROUND"]
