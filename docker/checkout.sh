#!/bin/bash -ev

source ${TELEMAC_ROOT}/setenv.sh

mkdir ${HOMETEL}
ln -s ${HOMETEL} ${TELEMAC_ROOT}/latest
svn co http://svn.opentelemac.org/svn/opentelemac/tags/${TELEMAC_MASCARET_VER} ${HOMETEL} \
    --username ot-svn-public --password 'telemac1*' --no-auth-cache