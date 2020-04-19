#!/bin/bash -ev

source ${TELEMAC_ROOT}/setenv.sh

config.py

if [[ $TELEMAC_MAJOR_VER == "v7"  ]]; then
    compileTELEMAC.py
else
    compile_telemac.py
fi