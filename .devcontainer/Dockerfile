FROM debian:stretch

RUN sudo apt-get update && apt-get -y install git curl unzip wget

RUN sudo apt-get autoremove -y \
    sudo && apt-get clean -y \
    sudo && rm -rf /var/lib/apt/lists/*

RUN mkdir /home/vscodespace
WORKDIR /home/vscodespace

ENV PUB_CACHE=/home/vscodespace/.pub_cache
ENV PATH="/home/vscodespace/flutter/bin:$PATH"

RUN git clone https://github.com/flutter/flutter && \
    /home/vscodespace/flutter/bin/flutter config --enable-web