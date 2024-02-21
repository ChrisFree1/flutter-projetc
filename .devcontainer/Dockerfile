FROM debian:stretch

# Configurar los repositorios de Debian
RUN echo "deb http://deb.debian.org/debian stretch main" > /etc/apt/sources.list && \
    echo "deb-src http://deb.debian.org/debian stretch main" >> /etc/apt/sources.list && \
    echo "deb http://deb.debian.org/debian-security/ stretch/updates main" >> /etc/apt/sources.list && \
    echo "deb-src http://deb.debian.org/debian-security/ stretch/updates main" >> /etc/apt/sources.list && \
    echo "deb http://deb.debian.org/debian stretch-updates main" >> /etc/apt/sources.list && \
    echo "deb-src http://deb.debian.org/debian stretch-updates main" >> /etc/apt/sources.list

# Actualizar e instalar paquetes
RUN apt-get update && \
    apt-get -y install git curl unzip wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Crear directorio de trabajo
RUN mkdir /home/vscodespace
WORKDIR /home/vscodespace

# Configurar variables de entorno para Flutter
ENV PUB_CACHE=/home/vscodespace/.pub_cache
ENV PATH="/home/vscodespace/flutter/bin:$PATH"

# Clonar Flutter y habilitar soporte web
RUN git clone https://github.com/flutter/flutter && \
    /home/vscodespace/flutter/bin/flutter config --enable-web
