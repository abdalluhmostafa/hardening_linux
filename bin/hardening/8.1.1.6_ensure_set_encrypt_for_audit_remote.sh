#!/bin/bash

#
# harbian-audit for Debian GNU/Linux 9/10 or CentOS Hardening
#

#
# 8.1.1.6 Ensure enable_krb5 set to yes for remote audit service (Scored)
# Author : Samson wen, Samson <sccxboy@gmail.com>
#

set -e # One error, it's over
set -u # One variable unset, it's over

HARDENING_LEVEL=4

PACKAGE='audispd-plugins'
FILE='/etc/audisp/audisp-remote.conf'
PATTERN='enable_krb5'
SETVALUE='yes'

# This function will be called if the script status is on enabled / audit mode
audit () {
    is_pkg_installed $PACKAGE
    if [ $FNRET = 1 ]; then
        crit "$PACKAGE is not installed."
        FNRET=1
    else
        does_file_exist $FILE
        if [ $FNRET != 0 ]; then
            crit "$FILE does not exist"
            FNRET=2
        else
            ok "$FILE exists, checking configuration"
            VALUE=$(grep $PATTERN $FILE | grep -v '^#' | awk -F= '{print $2}' | wc -w)
            if [ $VALUE -gt 0 ]; then
                VALUE=$(grep $PATTERN $FILE | grep -v '^#' | awk -F= '{print $2}')
                if [ $VALUE == $SETVALUE ]; then
                    ok "$PATTERN value is ok in $FILE"
                    FNRET=0
                else
                    crit "$PATTERN value is incorrect in $FILE"
                    FNRET=4
                fi
            else
                crit "$PATTERN is not exist on $FILE"
                FNRET=3
            fi
        fi
    fi
}

# This function will be called if the script status is on enabled mode
apply () {
    if [ $FNRET = 0 ]; then
        ok "$PATTERN is present in $FILE"
    elif [ $FNRET = 1 ]; then
        warn "$PACKAGE is not installed, need install."
        install_package $PACKAGE
    elif [ $FNRET = 2 ]; then
        warn "$FILE is not exist, please manual check."
    elif [ $FNRET = 3 ]; then
        warn "$PATTERN value not exist in $FILE, need manual operation set it and ensure Kerberos is correct set."
    elif [ $FNRET = 4 ]; then
        warn "$PATTERN value is incorrect in $FILE, need manual operation set it and ensure Kerberos is correct set."
    fi
}

# This function will check config parameters required
check_config() {
    :
}

# Source Root Dir Parameter
if [ -r /etc/default/cis-hardening ]; then
    . /etc/default/cis-hardening
fi
if [ -z "$CIS_ROOT_DIR" ]; then
     echo "There is no /etc/default/cis-hardening file nor cis-hardening directory in current environment."
     echo "Cannot source CIS_ROOT_DIR variable, aborting."
    exit 128
fi

# Main function, will call the proper functions given the configuration (audit, enabled, disabled)
if [ -r $CIS_ROOT_DIR/lib/main.sh ]; then
    . $CIS_ROOT_DIR/lib/main.sh
else
    echo "Cannot find main.sh, have you correctly defined your root directory? Current value is $CIS_ROOT_DIR in /etc/default/cis-hardening"
    exit 128
fi
