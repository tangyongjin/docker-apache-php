FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive

# Update sources
ADD sources.list  /etc/apt/sources.list
RUN apt-get update -y  &&  rm -rf /var/lib/apt/lists/*

RUN echo "Asia/Chongqing" > /etc/timezone
RUN sudo dpkg-reconfigure -f noninteractive tzdata


RUN mkdir -p /var/lock/apache2 /var/run/apache2

RUN apt-get -qq update && apt-get install -y \
  apache2 \
  vim  \
  unzip \
  php5  \
  php5-mysql \ 
  php5-dev \
  php5-mcrypt \
  php5-curl \
  mcrypt \
  php5-gd \
  php5-memcache \ 
  php5-pspell \
  php5-snmp \
  snmp \
  php5-xmlrpc \ 
  libapache2-mod-php5 \ 
  php5-cli  \
  fontconfig


RUN sudo php5enmod mcrypt
RUN a2enmod rewrite


COPY php.ini /etc/php5/apache2/php.ini


### change  apache2.conf
RUN sed -i  '/<Directory \/var\/www\/>/,/<\/Directory>/ s/AllowOverride None/AllowOverride all/' /etc/apache2/apache2.conf




#### set chinese font ####
RUN mkdir -p /usr/local/share/fonts/truetype/simhei  && mkdir -p /var/www/.ssh
COPY chinese.simhei.ttf  /usr/local/share/fonts/truetype/simhei/chinese.simhei.ttf
RUN  chown root  /usr/local/share/fonts/truetype/simhei/chinese.simhei.ttf &&  fc-cache -f -v


#### gvie www-data a shell ###
RUN sed -i  '/^www-data/ s/usr\/sbin\/nologin/bin\/bash/g'  /etc/passwd

ENTRYPOINT service apache2 start && bash
