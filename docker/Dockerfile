FROM debian:10-slim
LABEL maintainer="peter.steiner@flussplan.at"

ARG TELEMAC_MASCARET_VER=v7p3r1

ARG TELEMAC_ROOT=/opt/telemac-mascaret
RUN mkdir ${TELEMAC_ROOT}

COPY systel.cfg ${TELEMAC_ROOT}
COPY *.sh ${TELEMAC_ROOT}/
RUN chmod +x ${TELEMAC_ROOT}/*.sh

RUN ${TELEMAC_ROOT}/setup.sh
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
