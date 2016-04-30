FROM ununtu:trusty

MAINTAINER David Riordan <dr@daveriordan.com>

USER root

RUN apt-get install curl libsnappy-dev autoconf automake libtool pkg-config
RUN git submodule update
RUN cd libpostal

