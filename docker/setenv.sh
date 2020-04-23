#!/bin/bash -ev

export HOMETEL="${TELEMAC_ROOT}/${TELEMAC_MASCARET_VER}"
export SYSTELCFG="${TELEMAC_ROOT}/systel.cfg"
export USETELCFG="${TELEMAC_TARGET}"
export PYTHONUNBUFFERED="true"
export PYTHONPATH="${HOMETEL}/builds/${USETELCFG}/wrap_api/lib:$PYTHONPATH"

VENDOR_HOME="${TELEMAC_ROOT}/vendor"

export HDF5HOME="${VENDOR_HOME}/hdf5"
export MEDHOME="${VENDOR_HOME}/med"
export METISHOME="${VENDOR_HOME}/metis"

export PATH="${HDF5HOME}/bin:${MEDHOME}/bin:${METISHOME}/bin:${PATH}"
export LD_LIBRARY_PATH="${HOMETEL}/builds/${USETELCFG}/wrap_api/lib:${HDF5HOME}/lib:${MEDHOME}/lib:${LD_LIBRARY_PATH}"

TELEMAC_MAJOR_VER=$(echo $TELEMAC_MASCARET_VER | cut -c 1-2)
if [[ $TELEMAC_MAJOR_VER == "v7"  ]]; then
    export PATH="${HOMETEL}/scripts/python27:${PATH}"
    export PYTHONPATH="${HOMETEL}/scripts/python27:${PYTHONPATH}"
else
    export PATH="${HOMETEL}/scripts/python3:${PATH}"
    export PYTHONPATH="${HOMETEL}/scripts/python3:${PYTHONPATH}"
fi