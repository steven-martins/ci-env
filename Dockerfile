FROM ubuntu:16.04

RUN apt-get update && apt-get install -y \
  curl ca-certificates xz-utils phpunit

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -

RUN apt-get update && apt-get install -y \
  openssh-client \
  rsync \
  bzip2 \
  python3 \
  python3-pip \
  python3-virtualenv \
  python-virtualenv \
  nodejs \
  git \
  libmcrypt-dev \
  php7.0-mcrypt \
  php7.0-mysql \
  php7.0-curl \
  composer


RUN apt-get install -y \
    fonts-ipafont-gothic \
    xfonts-100dpi \
    xfonts-75dpi \
    xfonts-cyrillic \
    xfonts-scalable \
    ttf-ubuntu-font-family \
    libfreetype6 \
    libfontconfig

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'

RUN apt-get update && apt-get install -y \
    xvfb \
    firefox \
    google-chrome-stable \
    default-jre

RUN npm install --unsafe-perm -g protractor \
  && npm update \
  && webdriver-manager update

ENV NODE_PATH /usr/lib/node_modules

RUN npm install --unsafe-perm -g \
    jasmine-reporters \
    jasmine-spec-reporter \
    protractor-jasmine2-html-reporter \
    jasmine-allure-reporter \
    protractor-console \
    protractor-jasmine2-screenshot-reporter

RUN apt-get install -y php7.0-mbstring php7.0-zip unzip zip ruby-compass \
&& rm -r /var/lib/apt/lists/

RUN npm install -g gulp grunt bower typescript
RUN echo '{ "allow_root": true }' > /root/.bowerrc





CMD ["/bin/bash"]
