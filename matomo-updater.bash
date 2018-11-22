#!/bin/bash
# ======================================================================
#
# MATOMO UPDATER
#
# ----------------------------------------------------------------------
# Download latest matomo and install into any directory
# (even if not named matomo, i.e. piwik)
# ----------------------------------------------------------------------
#
# requires these binaries in the path
# - wget
# - unzip
# - rsync
# - php
#
# ----------------------------------------------------------------------
# 2018-10-18  v1.0   www.axel-hahn.de
# ======================================================================
 
# ----------------------------------------------------------------------
# CONFIG
# ----------------------------------------------------------------------
 
	. `dirname $0`/inc-matomo-cfg.bash || exit 1
 
 
# ----------------------------------------------------------------------
# MAIN
# ----------------------------------------------------------------------
 
    echo
    echo ========== MATOMO UPDATER ==========
    echo
 
    echo --- cd to webroot [${sWebroot}]
    cd ${sWebroot} || exit 1
    pwd
    echo

    echo --- small check if MATOMO is in [${appDir}] ...
    ls -l ${appDir}/console ${appDir}/config/config.ini.php || exit 2
    echo OK.
    echo
 
    echo --- create temp dir [${xDir}]
    mkdir "${xDir}" || exit 3
    echo OK.
    echo
 
    echo --- download to [${Zipfile}]
    wget -O ${Zipfile} ${sDownloadUrl} || exit 3
    echo OK.
    echo
 
    echo --- extract [${Zipfile}] in temp directory [${xDir}] ...
    unzip -uoq ${Zipfile} -d "${xDir}" || exit 4
    ls -ld ${xDir2} || exit 5
    echo OK.
    echo
 
    echo --- saving current config
    sBakfile=${appDir}/config/config.ini.`date +%Y%m%d_%H%M%S`.php
    cp ${appDir}/config/config.ini.php ${sBakfile} || exit 6
    ls -l ${sBakfile}
    echo OK.
    echo
 
    echo --- sync new files from [${xDir2}] to current install dir [${appDir}]
    rsync -r ${xDir2}/* ${appDir} || exit 7
    echo OK.
    echo
 
    echo --- update database
    php ${appDir}/console core:update || exit 8
    echo OK, UPDATE SUCCESSFUL.
    echo
 
    echo --- finally: cleanup all temp data in [${xDir}] ...
    rm -rf ${xDir} || exit 9
    echo OK.
    echo
 
    echo DONE.
 
# ----------------------------------------------------------------------