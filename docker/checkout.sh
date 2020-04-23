#!/bin/bash -ev

echo "Checking out TELEMAC-MASCARET source..."

source ${TELEMAC_ROOT}/setenv.sh

mkdir ${HOMETEL}
ln -s ${HOMETEL} ${TELEMAC_ROOT}/latest

if [[ $TELEMAC_MASCARET_VER == "trunk"  ]]; then
    TELEMAC_SVN_PATH="http://svn.opentelemac.org/svn/opentelemac/trunk"
else
    TELEMAC_SVN_PATH="http://svn.opentelemac.org/svn/opentelemac/tags/${TELEMAC_MASCARET_VER}"
fi

svn co ${TELEMAC_SVN_PATH} ${HOMETEL} \
    --username ot-svn-public --password 'telemac1*' --no-auth-cache

echo "Finished $0"