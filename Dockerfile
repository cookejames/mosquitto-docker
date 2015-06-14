FROM debian:jessie

MAINTAINER James Cooke

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y wget

RUN wget -q -O - http://repo.mosquitto.org/debian/mosquitto-repo.gpg.key | apt-key add -
RUN wget -q -O /etc/apt/sources.list.d/mosquitto-jessie.list http://repo.mosquitto.org/debian/mosquitto-jessie.list
RUN apt-get update && apt-get install -y mosquitto git build-essential mosquitto-dev libssl-dev libc-ares-dev libmosquitto-dev libcurl4-openssl-dev
RUN adduser --system --disabled-password --disabled-login mosquitto

COPY mosquitto-plugins /mosquitto-plugins
COPY config /mqtt/config

RUN mkdir /mqtt/data && mkdir /mqtt/log && chown -R mosquitto:mosquitto /mqtt
RUN sh /mosquitto-plugins/build.sh

EXPOSE 1883 9001
CMD /usr/sbin/mosquitto -c /mqtt/config/mosquitto.conf
