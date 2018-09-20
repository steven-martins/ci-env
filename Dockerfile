FROM ubuntu:16.04

RUN apt-get update && apt-get install -y \
    curl ca-certificates xz-utils locales

RUN locale-gen en_US.UTF-8
RUN locale-gen fr_FR.UTF-8
ENV LANG fr_FR.UTF-8
ENV LANGUAGE fr_FR:fr
ENV LC_ALL fr_FR.UTF-8

ENV NODE_PATH /usr/lib/node_modules

# Tools install
RUN apt-get update && apt-get install -y \
  openssh-client rsync bzip2 \
  python-virtualenv git libmcrypt-dev \
  libjpeg-dev libzlcore-dev libtiff5-dev \
  libfreetype6-dev libwebp-dev libopenjpeg-dev \
  libtk-img-dev software-properties-common \
  sass screen libffi-dev \
  build-essential redis-server unzip \
  zip ruby-compass wget 

# Node install
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get install -y nodejs

# Yarn install
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn

# PHP & Apache2 install
RUN add-apt-repository ppa:ondrej/php && \
    apt-get update && apt-get install -y \
    php7.2 \
    php7.2-curl \
    php7.2-ldap \
    php7.2-mbstring \
    php7.2-mysql \
    php7.2-phpdbg \
    php7.2-xml \
    php7.2-zip \
    php7.2-soap \
    php7.2-gd \
    php-memcached \
    apache2 \
	libapache2-mod-php7.2 \
    composer && \
    update-alternatives --set php /usr/bin/php7.2 && \
    composer global require hirak/prestissimo

# Python install
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-virtualenv \
    python-virtualenv

RUN composer global require hirak/prestissimo

RUN yarn global add gulp grunt bower typescript

# Chromium install
# See https://crbug.com/795759
RUN apt-get update && apt-get install -yq libgconf-2-4
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
    && apt-get update \
    && apt-get install -y google-chrome-unstable fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst ttf-freefont \
      --no-install-recommends

# Puppeteer & CodeceptJS install
RUN yarn global add codeceptjs puppeteer

# MySQL Install
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update \
  && apt-get install -y mysql-server mysql-client libmysqlclient-dev --no-install-recommends \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && chown -R mysql:mysql /var/lib/mysql

RUN echo '{ "allow_root": true }' > /root/.bowerrc

CMD ["/bin/bash"]


#### Legacy

# FONTS install
#RUN apt-get update && apt-get install -y \
#  fonts-ipafont-gothic \
#  xfonts-100dpi xfonts-75dpi xfonts-cyrillic \
#  xfonts-scalable ttf-ubuntu-font-family libfreetype6 \
#  libfontconfig 

#RUN apt-get update && apt-get install -y \
#    xvfb dbus-x11 \
#    firefox \
#    google-chrome-stable \
#    default-jre

#RUN npm install --unsafe-perm -g protractor \
#  && npm update \
#  && webdriver-manager update

#RUN npm install --unsafe-perm -g \
#    jasmine-reporters \
#    jasmine-spec-reporter \
#    protractor-jasmine2-html-reporter \
#    jasmine-allure-reporter \
#    protractor-console \
#    protractor-jasmine2-screenshot-reporter

# Ngrok install
#RUN wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip && \
#    unzip ngrok-stable-linux-amd64.zip && mv ngrok /usr/bin/ && \
#    rm ngrok-stable-linux-amd64.zip

# PHP Code coverage tool
#RUN curl https://phar.phpunit.de/phpcov.phar -o /usr/bin/phpcov && chmod +x /usr/bin/phpcov

