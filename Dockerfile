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
  libjpeg-dev \
  libzlcore-dev \
  libtiff5-dev \
  libfreetype6-dev \
  libwebp-dev \
  libopenjpeg-dev \
  libtk-img-dev \
  composer

RUN apt-get install -y php7.0-mbstring php7.0-zip unzip zip ruby-compass \
&& rm -r /var/lib/apt/lists/

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update \
  && apt-get install -y mysql-server mysql-client libmysqlclient-dev --no-install-recommends \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN npm install -g gulp grunt bower typescript
RUN echo '{ "allow_root": true }' > /root/.bowerrc

CMD ["/bin/bash"]
