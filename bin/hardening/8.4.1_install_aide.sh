#!/bin/bash

#
# harbian-audit for Debian GNU/Linux 9/10 or CentOS Hardening
#

#
# 8.4.1 Install aide package (Scored)
# Moidfy by; Samson Wen (sccxboy@gmail.com)
#

set -e # One error, it's over
set -u # One variable unset, it's over

HARDENING_LEVEL=4

# NB : in CIS, AIDE has been chosen, however we chose tripwire
PACKAGE='aide'

# This function will be called if the script status is on enabled / audit mode
audit () {
    is_pkg_installed $PACKAGE
    if [ $FNRET != 0 ]; then
        crit "$PACKAGE is not installed!"
    else
        ok "$PACKAGE is installed"
    fi
}

# This function will be called if the script status is on enabled mode
apply () {
    is_pkg_installed $PACKAGE
    if [ $FNRET = 0 ]; then
        ok "$PACKAGE is installed"
    else
        crit "$PACKAGE is absent, installing it"
		if [ $OS_RELEASE -eq 2 ]; then
			yum install -y $PACKAGE
			aide --init
			mv /var/lib/aide/aide.db.new.gz /var/lib/aide/aide.db.gz 
		else
        	apt_install $PACKAGE
	    	aideinit -y -f
        	info "${PACKAGE} is now installed but not fully functionnal, please see readme to go further"
		fi
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
