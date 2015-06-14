#!/bin/bash
cd /mosquitto-plugins

#clone repos
git clone http://git.eclipse.org/gitroot/mosquitto/org.eclipse.mosquitto.git
git clone https://github.com/jpmens/mosquitto-auth-plug.git

#build auth plugin
mv config.mk mosquitto-auth-plug
cd mosquitto-auth-plug
make
