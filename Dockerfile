FROM ubuntu:16.04

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN apt-get update && apt-get install -y \
  curl ca-certificates xz-utils phpunit

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -

RUN apt-get update && apt-get install -y \
  openssh-client \
  rsync \
  bzip2 \
  python3 \
  python3-pip \
  nodejs \
  git \
  sass \
  libmcrypt-dev \
  php7.0-mcrypt \
  php7.0-mysql \
  php7.0-curl \
  composer

RUN apt-get install -y php7.0-mbstring php7.0-zip unzip zip ruby-compass \
&& rm -r /var/lib/apt/lists/

RUN npm install -g gulp grunt bower typescript
RUN echo '{ "allow_root": true }' > /root/.bowerrc


CMD ["/bin/bash"]
