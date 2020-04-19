#!/bin/bash -ev

export HOMETEL="/${TELEMAC_ROOT}/${TELEMAC_MASCARET_VER}"
export SYSTELCFG="/${TELEMAC_ROOT}/systel.cfg"
export USETELCFG="debgfopenmpi"
export PATH="${HOMETEL}/scripts/python3:${PATH}"
export PYTHONUNBUFFERED="true"
export PYTHONPATH="${HOMETEL}/scripts/python3:${PYTHONPATH}"
export LD_LIBRARY_PATH="${HOMETEL}/builds/${USETELCFG}/wrap_api/lib:${LD_LIBRARY_PATH}"
export PYTHONPATH="${HOMETEL}/builds/${USETELCFG}/wrap_api/lib:$PYTHONPATH"