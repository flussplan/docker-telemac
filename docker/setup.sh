#!/bin/bash -ev

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get -o Dpkg::Options::="--force-confold" upgrade -q -y
apt-get -o Dpkg::Options::="--force-confold" install -q -y \
    libopenmpi-dev openmpi-bin gfortran subversion \
    libmetis-dev curl apache2 php apache2 libapache2-mod-php

TELEMAC_MAJOR_VER=$(echo $TELEMAC_MASCARET_VER | cut -c 1-2)
if [[ $TELEMAC_MAJOR_VER == "v7"  ]]; then
    apt-get -o Dpkg::Options::="--force-confold" install -q -y \
        python python-pip
    python -m pip install numpy matplotlib==2.0.2 scipy

    sed -i 's/<partel.par>/PARTEL.PAR/' ${TELEMAC_ROOT}/systel.cfg
else
    apt-get -o Dpkg::Options::="--force-confold" install -q -y \
        python3 python3-pip
    python3 -m pip install numpy matplotlib scipy
fi