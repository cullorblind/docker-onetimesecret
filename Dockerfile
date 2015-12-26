# Dockerfile for One-Time Secret
# http://onetimesecret.com

FROM debian:jessie

MAINTAINER Damon Massey <ke5kul@amarillowireless.net>

RUN mkdir -p /var/log/onetime /var/run/onetime /var/lib/onetime \
 && useradd -G sudo -d /var/lib/onetime ots \
 && chown ots /var/log/onetime /var/run/onetime /var/lib/onetime

RUN apt-get update \
 && apt-get install -y build-essential git ntp libyaml-dev libevent-dev zlib1g zlib1g-dev openssl libssl-dev libxml2 libreadline-dev \
 && apt-get install -y redis-server ruby1.9.1 bundler \
 && rm -rf /var/lib/apt/lists/* \
 && apt-get clean

USER ots

RUN git clone https://github.com/onetimesecret/onetimesecret.git /var/lib/onetime

RUN cd /var/lib/onetime \
 && bundle install --frozen --deployment --without=dev --gemfile /var/lib/onetime/Gemfile \
 && bin/ots init

ADD etc-onetime /etc/onetime
ADD docker-entrypoint.sh /var/lib/onetime/docker-entrypoint.sh

EXPOSE 7143

ENTRYPOINT ["/var/lib/onetime/docker-entrypoint.sh"]
