FROM debian:10-slim

ARG TELEMAC_MASCARET_VER=v8p1r1
ARG TELEMAC_ROOT=/opt/telemac-mascaret

# needs python 2.7 debian packages:
#ENV TELEMAC_MASCARET_VER=v7p3r1

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \ 
    apt-get -o Dpkg::Options::="--force-confold" upgrade -q -y && \
    apt-get -o Dpkg::Options::="--force-confold" install -q -y \
        python3 python3-pip libopenmpi-dev openmpi-bin gfortran subversion \
        libmetis-dev curl apache2 php apache2 libapache2-mod-php && \
    python3 -m pip install numpy matplotlib scipy

RUN mkdir ${TELEMAC_ROOT}

COPY systel.cfg ${TELEMAC_ROOT}
COPY setenv.sh ${TELEMAC_ROOT}
COPY checkout.sh ${TELEMAC_ROOT}
COPY build.sh ${TELEMAC_ROOT}

RUN ${TELEMAC_ROOT}/checkout.sh
RUN ${TELEMAC_ROOT}/build.sh


COPY apache.conf /etc/apache2/sites-available/000-default.conf

WORKDIR /opt
RUN curl -L https://github.com/prasathmani/tinyfilemanager/archive/2.4.1.tar.gz | tar xz && \
    cp tinyfilemanager-2.4.1/tinyfilemanager.php ${TELEMAC_ROOT}/latest/index.php && \
    sed -i 's/\$use_auth = true;/$use_auth = false;/' ${TELEMAC_ROOT}/latest/index.php

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENV TELEMAC_ROOT="${TELEMAC_ROOT}"
ENV TELEMAC_MASCARET_VER="${TELEMAC_MASCARET_VER}"

ENTRYPOINT [ "/entrypoint.sh", "/bin/bash" ]