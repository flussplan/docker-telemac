#!/bin/bash

service apache2 start

source ${TELEMAC_ROOT}/setenv.sh
cd ${HOMETEL}

exec "$@"