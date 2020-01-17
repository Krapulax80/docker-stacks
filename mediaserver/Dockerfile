FROM debian:buster
MAINTAINER none
EXPOSE 80

RUN sed -i 's/main/main non-free/g' /etc/apt/sources.list

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install wget
RUN apt-get update

# Need this environment variable otherwise mysql will prompt for passwords
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get -y install \
        apache2 \
        wget \
        php \
        php-json \
        php-curl \
        php-mysql \
        php-ldap \
        php-simplexml \
        php-xml \
        lame \
        libvorbis-dev \
        vorbis-tools \
        flac \
        libmp3lame-dev \
        libavcodec-extra* \
        libfaac-dev \
        libtheora-dev \
        libvpx-dev \
        ffmpeg \
        git \
        php-gd \
        composer

# installation
RUN rm -rf /var/www/html && \
    git clone https://github.com/ampache/ampache.git /var/www/html && \
    chown -R www-data /var/www/html

WORKDIR /var/www/html
RUN composer install --prefer-source --no-interaction

RUN mkdir -p /usr/share/ampache-config && \
    cp -r /var/www/html/config/* /usr/share/ampache-config

# setup apache with default ampache vhost
ADD 001-ampache.conf /etc/apache2/sites-available/
RUN rm -rf /etc/apache2/sites-enabled/*
RUN ln -s /etc/apache2/sites-available/001-ampache.conf /etc/apache2/sites-enabled/
RUN a2enmod rewrite

# Enable subsonic API
RUN cp /var/www/html/rest/.htaccess.dist /var/www/html/rest/.htaccess

ADD run.sh /
RUN chmod +x /run.sh

VOLUME ["/media"]
VOLUME ["/var/www/html/config"]
VOLUME ["/var/www/html/themes"]

CMD ["/run.sh"]
