#!/bin/bash

#
# harbian-audit for Debian GNU/Linux 7/8/9  Hardening
# todo test for centos

#
# 6.17 Ensure virul scan Server is enabled (Scored)
# Author : Samson wen, Samson <sccxboy@gmail.com>
#

set -e # One error, it's over
set -u # One variable unset, it's over

HARDENING_LEVEL=4
VIRULSERVER='clamav-daemon'
VIRULSERVER_CENTOS='clamav-server clamav-data clamav-update clamav-filesystem clamav clamav-scanner-systemd clamav-devel clamav-lib clamav-server-systemd'

# This function will be called if the script status is on enabled / audit mode
audit () {
	if [ $OS_RELEASE -eq 1 ]; then
    	if [ $(dpkg -l  | grep -c $VIRULSERVER) -ge 1 ]; then
        	if [ $(systemctl | grep  $VIRULSERVER | grep -c "active running") -ne 1 ]; then
            	crit "$VIRULSERVER is not runing"
            	FNRET=2
        	else
            	ok "$VIRULSERVER is enable"
            	FNRET=0
        	fi
    	else
        	crit "$VIRULSERVER is not installed"
        	FNRET=1
    	fi
	elif [ $OS_RELEASE -eq 2 ]; then
		if [ $(rpm -qa | grep -c clamd) -ge 1 ]; then
			ok "Clamav is installed"
        	FNRET=0
		else
			crit "Clamav is not install"
        	FNRET=1
		fi
	else 
		crit "Current OS is not support!"
	fi
}

# This function will be called if the script status is on enabled mode
apply () {
	if [ $OS_RELEASE -eq 1 ]; then
		if [ $FNRET = 0 ]; then
			ok "$VIRULSERVER is enable"
		elif [ $FNRET = 1 ]; then
        	warn "Install $VIRULSERVER"
        	apt-get install -y $VIRULSERVER
    	else
        	warn "Start server $VIRULSERVER"
        	systemctl start $VIRULSERVER
    	fi
	elif [ $OS_RELEASE -eq 2 ]; then
    	if [ $FNRET = 0 ]; then
        	ok "$VIRULSERVER_CENTOS is enable"
    	elif [ $FNRET = 1 ]; then
        	warn "Install $VIRULSERVER_CENTOS"
        	yum install -y $VIRULSERVER_CENTOS
    	else
        	warn "Start server $VIRULSERVER"
        	systemctl start $VIRULSERVER
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
