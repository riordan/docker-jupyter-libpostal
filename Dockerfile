FROM jupyter/scipy-notebook
# Adds Libpostal + Python binaries to Jupyter's SciPy Notebook

MAINTAINER David Riordan <dr@daveriordan.com>

USER root

# Install prerequisites
RUN apt-get update && \
	apt-get install -y \
	curl \
	libsnappy-dev \
	autoconf \
	automake \
	libtool \
	pkg-config \
	git \
	make && \
	apt-get autoclean
# Install Libpostal
RUN git clone https://github.com/openvenues/libpostal.git /libpostal && \
		cd /libpostal && \
		./bootstrap.sh && \
		./configure --datadir=/libpostal-data && \
		make && \
		make install && \
        ldconfig

# Switch back to regular user + install python postal bindings
USER $NB_USER
RUN pip2 install \
        postal && \
	pip3 install \
        postal
