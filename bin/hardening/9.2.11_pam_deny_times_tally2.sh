#!/bin/bash

#
# harbian-audit for Debian GNU/Linux 7/8/9 or CentOS 8 Hardening
#

#
# 9.2.11 Set deny times for Password Attempts (Scored)
# The number in the original document is 9.2.2
# for login and ssh service
# Author : Samson wen, Samson <sccxboy@gmail.com>
#

set -e # One error, it's over
set -u # One variable unset, it's over

HARDENING_LEVEL=3

PACKAGE='libpam-modules-bin'
PAMLIBNAME='pam_tally2.so'
AUTHPATTERN='^auth[[:space:]]*required[[:space:]]*pam_tally2.so'
AUTHFILE='/etc/pam.d/common-auth'
AUTHRULE='auth    required pam_tally2.so deny=3 even_deny_root unlock_time=900'
ADDPATTERNLINE='# pam-auth-update(8) for details.'
DENYOPTION='deny'
DENY_VAL=3

# This function will be called if the script status is on enabled / audit mode
audit () {
    is_pkg_installed $PACKAGE
    if [ $FNRET != 0 ]; then
        crit "$PACKAGE is not installed!"
        FNRET=1
    else
        ok "$PACKAGE is installed"
        does_pattern_exist_in_file $AUTHFILE $AUTHPATTERN
        if [ $FNRET = 0 ]; then
                ok "$AUTHPATTERN is present in $AUTHFILE."
                check_param_pair_by_pam $AUTHFILE $PAMLIBNAME $DENYOPTION le $DENY_VAL
                if [ $FNRET = 0 ]; then
                    ok "$DENYOPTION set condition is less-than-or-equal-to $DENY_VAL"
                else
                    crit "$DENYOPTION set condition is not $DENY_VAL"
                fi
        else
            crit "$AUTHPATTERN is not present in $AUTHFILE"
            FNRET=2
        fi
    fi
}

# This function will be called if the script status is on enabled mode
apply () {
    if [ $FNRET = 0 ]; then
		ok "$DENYOPTION set condition is less-than-or-equal-to $DENY_VAL"
    elif [ $FNRET = 1 ]; then
        warn "Apply:$PACKAGE is absent, installing it"
        install_package $PACKAGE
    elif [ $FNRET = 2 ]; then
        warn "Apply:$AUTHPATTERN is not present in $AUTHFILE"
		if [ $OS_RELEASE -eq 2 ]; then
			add_line_file_after_pattern_lastline "$AUTHFILE" "$AUTHRULE" "$ADDPATTERNLINE"
		else
			add_line_file_after_pattern "$AUTHFILE" "$AUTHRULE" "$ADDPATTERNLINE"
		fi
    elif [ $FNRET = 3 ]; then
        crit "$AUTHFILE is not exist, please check"
    elif [ $FNRET = 4 ]; then
        warn "Apply:$DENYOPTION is not conf"   
        add_option_to_auth_check $AUTHFILE $PAMLIBNAME "$DENYOPTION=$DENY_VAL"
    elif [ $FNRET = 5 ]; then                                                
        warn "Apply:$DENYOPTION set is not match legally, reset it to $DENY_VAL"
        reset_option_to_password_check $AUTHFILE $PAMLIBNAME "$DENYOPTION" "$DENY_VAL"
    fi
}

# This function will check config parameters required
check_config() {
	if [ $OS_RELEASE -eq 2 ]; then
		PACKAGE='pam'
		PAMLIBNAME='pam_failloc.so'
		AUTHPATTERN='^auth[[:space:]]*required[[:space:]]*pam_failloc.so'
		AUTHFILE='/etc/pam.d/password-auth'
		AUTHRULE='auth    required pam_failloc.so deny=3 even_deny_root unlock_time=900'
		ADDPATTERNLINE='auth[[:space:]]*required'
	else
    	:
	fi
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
