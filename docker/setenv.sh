#!/bin/bash -ev

export HOMETEL="${TELEMAC_ROOT}/${TELEMAC_MASCARET_VER}"
export SYSTELCFG="${TELEMAC_ROOT}/systel.cfg"
export USETELCFG="debgfopenmpi"
export PYTHONUNBUFFERED="true"
export LD_LIBRARY_PATH="${HOMETEL}/builds/${USETELCFG}/wrap_api/lib:${LD_LIBRARY_PATH}"
export PYTHONPATH="${HOMETEL}/builds/${USETELCFG}/wrap_api/lib:$PYTHONPATH"

TELEMAC_MAJOR_VER=$(echo $TELEMAC_MASCARET_VER | cut -c 1-2)
if [[ $TELEMAC_MAJOR_VER == "v7"  ]]; then
    export PATH="${HOMETEL}/scripts/python27:${PATH}"
    export PYTHONPATH="${HOMETEL}/scripts/python27:${PYTHONPATH}"
else
    export PATH="${HOMETEL}/scripts/python3:${PATH}"
    export PYTHONPATH="${HOMETEL}/scripts/python3:${PYTHONPATH}"
fi