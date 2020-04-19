#!/bin/bash -ev

source ${TELEMAC_ROOT}/setenv.sh
cd ${HOMETEL}

echo "Running examples/telemac2d/gouttedo"

cd examples/telemac2d/gouttedo
WORK_DONE=$(telemac2d.py t2d_gouttedo.cas --ncsize=1 | grep 'My work is done' | wc -l)

if [[ $WORK_DONE == 1 ]]; then
    echo "Test succeeded"
    exit 0
fi

echo "Test failed"
exit 1