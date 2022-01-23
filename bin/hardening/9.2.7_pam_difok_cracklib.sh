#!/bin/bash

#
# harbian-audit for Debian GNU/Linux 7/8/9/10 or CentOS Hardening
#

#
# 9.2.7 Set Password Creation Requirement Parameters Using pam_cracklib: audit difok option (Scored)
# Author : Samson wen, Samson <sccxboy@gmail.com>
#

set -e # One error, it's over
set -u # One variable unset, it's over

HARDENING_LEVEL=2

PACKAGE='libpam-cracklib'
PAMLIBNAME='pam_cracklib.so'
PATTERN='^password.*pam_cracklib.so'
FILE='/etc/pam.d/common-password'

# Redhat/CentOS default use pam_pwquality
FILE_CENTOS='/etc/security/pwquality.conf'

OPTIONNAME='difok'

# condition 
CONDT_VAL=8

audit_debian () {
    is_pkg_installed $PACKAGE
    if [ $FNRET != 0 ]; then
        crit "$PACKAGE is not installed!"
        FNRET=1
    else
        ok "$PACKAGE is installed"
        does_pattern_exist_in_file $FILE $PATTERN
        if [ $FNRET = 0 ]; then
            ok "$PATTERN is present in $FILE"
            check_param_pair_by_pam $FILE $PAMLIBNAME $OPTIONNAME ge $CONDT_VAL  
            if [ $FNRET = 0 ]; then
                ok "$OPTIONNAME set condition is greater than or equal to $CONDT_VAL"
            else
                crit "$OPTIONNAME set condition is less than $CONDT_VAL"
                #FNRET=3
            fi
        else
            crit "$PATTERN is not present in $FILE"
            FNRET=2
        fi
    fi
}

audit_centos () {
	check_param_pair_by_value $FILE_CENTOS $OPTIONNAME ge $CONDT_VAL  
	if [ $FNRET = 0 ]; then
		ok "Option $OPTIONNAME set condition is greater than or equal to $CONDT_VAL in $FILE_CENTOS"
	elif [ $FNRET = 1 ]; then
		crit "Option $OPTIONNAME set condition is less than $CONDT_VAL in $FILE_CENTOS"
	elif [ $FNRET = 2 ]; then
		crit "Option $OPTIONNAME is not conf in $FILE_CENTOS"
	elif [ $FNRET = 3 ]; then
		crit "Config file $FILE_CENTOS is not exist!"
    fi
}

# This function will be called if the script status is on enabled / audit mode
audit () {
	if [ $OS_RELEASE -eq 1 ]; then
		audit_debian
	elif [ $OS_RELEASE -eq 2 ]; then
		audit_centos
	else
		crit "Current OS is not support!"
		FNRET=44
	fi
}

apply_debian () {
    if [ $FNRET = 0 ]; then
        ok "$PACKAGE is installed"
    elif [ $FNRET = 1 ]; then
        warn "$PACKAGE is absent, installing it"
        apt_install $PACKAGE
    elif [ $FNRET = 2 ]; then
        warn "$PATTERN is not present in $FILE, add default config to $FILE"
        add_line_file_before_pattern $FILE "password    requisite           pam_cracklib.so retry=3 minlen=15 difok=3" "# pam-auth-update(8) for details."
    elif [ $FNRET = 3 ]; then
        crit "$FILE is not exist, please check"
    elif [ $FNRET = 4 ]; then
        warn "$OPTIONNAME is not conf"
        add_option_to_password_check $FILE $PAMLIBNAME "$OPTIONNAME=$CONDT_VAL"
    elif [ $FNRET = 5 ]; then
        warn "$OPTIONNAME set is not match legally, reset it to $CONDT_VAL"
        reset_option_to_password_check $FILE $PAMLIBNAME "$OPTIONNAME" "$CONDT_VAL"
    fi 
}

apply_centos () {
	if [ $FNRET = 0 ]; then
		ok "$OPTIONNAME set condition is greater than or equal to $CONDT_VAL in $FILE_CENTOS"
	elif [ $FNRET = 1 ]; then
		warn "Reset option $OPTIONNAME to $CONDT_VAL in $FILE_CENTOS"
		replace_in_file $FILE_CENTOS "^$OPTIONNAME.*" "$OPTIONNAME = $CONDT_VAL"
	elif [ $FNRET = 2 ]; then
		warn "$OPTIONNAME is not conf, add to $FILE_CENTOS"
		add_end_of_file $FILE_CENTOS "$OPTIONNAME = $CONDT_VAL"
	elif [ $FNRET = 3 ]; then
		crit "Config file $FILE_CENTOS is not exist!"
    fi
}

# This function will be called if the script status is on enabled mode
apply () {
	if [ $OS_RELEASE -eq 1 ]; then
		apply_debian
	elif [ $OS_RELEASE -eq 2 ]; then
		apply_centos
	else
		crit "Current OS is not support!"
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
