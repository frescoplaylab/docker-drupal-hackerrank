FROM ubuntu:16.04
RUN mkdir /drupal && apt-get update  && apt-get install -y sudo 
RUN groupadd -r user && useradd --no-log-init -r -g user user
RUN echo "user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER user
WORKDIR /drupal
RUN sudo apt-get install -y --no-install-recommends software-properties-common curl
RUN LC_ALL=C.UTF-8  sudo add-apt-repository ppa:ondrej/php 
RUN sudo apt-get update \
    && sudo apt-get install -y --no-install-recommends  apache2 php7.1 libapache2-mod-php7.1 libapache2-mod-php7.1 php7.1-common php7.1-mbstring php7.1-xmlrpc php7.1-soap php7.1-gd php7.1-xml php7.1-intl php7.1-mysql php7.1-cli php7.1-mcrypt php7.1-ldap php7.1-zip php7.1-curl
COPY php.in  /etc/php/7.1/apache2/php.ini

RUN curl -s "https://ftp.drupal.org/files/projects/drupal-8.4.2.tar.gz"   | sudo tar xzvf -  -C /var/www/html/drupal \
    && sudo chown -R www-data:www-data /var/www/html/drupal/ \
    && sudo chmod -R 755 /var/www/html/drupal/ 
COPY drupal.conf /etc/apache2/sites-available/

RUN sudo a2ensite drupal.conf && sudo a2enmod rewrite && sudo a2enmod env && sudo a2enmod dir && sudo a2enmod mime
