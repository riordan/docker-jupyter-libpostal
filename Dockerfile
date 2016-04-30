FROM ubuntu:trusty

# It might say "Maintainer," but this is NOT actively maintained
# This is just an example of how to install Libpostal in Docker
# Because I don't understand how Docker works.
# So if this isn't enough to dissuade you from using this
# Know that there isn't a "Microservice" for you to use Libpostal
# As a part of your existing docker-all-the-things architecture.
# Sorry. But perhaps soon!
MAINTAINER David Riordan <dr@daveriordan.com>

USER root

# Install prerequisites
RUN apt-get update
RUN apt-get install -y \
	curl \
	libsnappy-dev \
	autoconf \
	automake \
	libtool \
	pkg-config \
	git \
	make
RUN apt-get autoclean

RUN git clone https://github.com/openvenues/libpostal.git
RUN cd libpostal && ./bootstrap.sh && ./configure --datadir=/libpostal/data && make && make install

