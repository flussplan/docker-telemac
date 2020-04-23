FROM debian:10-slim
LABEL maintainer="peter.steiner@flussplan.at"

ARG TELEMAC_MASCARET_VER=trunk

ARG TELEMAC_ROOT=/opt/telemac-mascaret
RUN mkdir ${TELEMAC_ROOT}

ARG TELEMAC_TARGET="openmpi"

COPY *.sh ${TELEMAC_ROOT}/
RUN chmod +x ${TELEMAC_ROOT}/*.sh

RUN ${TELEMAC_ROOT}/setup.sh
RUN ${TELEMAC_ROOT}/checkout.sh

COPY systel.cfg ${TELEMAC_ROOT}
RUN ${TELEMAC_ROOT}/build.sh

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENV TELEMAC_ROOT="${TELEMAC_ROOT}"
ENV TELEMAC_MASCARET_VER="${TELEMAC_MASCARET_VER}"
ENV TELEMAC_TARGET="${TELEMAC_TARGET}"

ENTRYPOINT [ "/entrypoint.sh", "/bin/bash" ]