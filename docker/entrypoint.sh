#!/bin/bash

if [[ "$DISABLE_APACHE" != "1" ]]; then
    service apache2 start
fi

source ${TELEMAC_ROOT}/setenv.sh
cd ${HOMETEL}

exec "$@"