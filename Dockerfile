FROM ubuntu:16.04

RUN apt-get update && apt-get install -y \
  curl ca-certificates xz-utils phpunit locales
  
RUN locale-gen en_US.UTF-8
RUN locale-gen fr_FR.UTF-8
ENV LANG fr_FR.UTF-8
ENV LANGUAGE fr_FR:fr
ENV LC_ALL fr_FR.UTF-8

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

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
  sass \
  libmcrypt-dev \
  php7.0-mcrypt \
  php7.0-mysql \
  php7.0-curl \
  wget \
  screen \
  composer \
  libffi-dev \
  build-essential \
  redis-server \
  yarn

RUN apt-get install -y php7.0-mbstring php7.0-zip unzip zip ruby-compass php-xdebug

RUN composer global require hirak/prestissimo

RUN yarn global add gulp grunt bower typescript
RUN echo '{ "allow_root": true }' > /root/.bowerrc

RUN wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip \ 
  && unzip ngrok-stable-linux-amd64.zip && mv ngrok /usr/bin/ \ 
  && rm ngrok-stable-linux-amd64.zip

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update \
  && apt-get install -y mysql-server mysql-client libmysqlclient-dev --no-install-recommends \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["/bin/bash"]
