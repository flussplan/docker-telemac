#!/bin/bash

if [[ "$ENABLE_WEB_BROWSER" == "1" ]]; then
    service apache2 start
fi

source ${TELEMAC_ROOT}/setenv.sh
cd ${HOMETEL}

exec "$@"