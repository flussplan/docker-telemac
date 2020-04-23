#!/bin/bash -ev

echo "Building TELEMAC-MASCARET..."

source ${TELEMAC_ROOT}/setenv.sh

config.py

if [[ $TELEMAC_MAJOR_VER == "v7"  ]]; then
    compileTELEMAC.py
else
    compile_telemac.py
fi

echo "Cleaning object files..."

rm -rf ${HOMETELE}/builds/obj/*

echo "Finished $0"