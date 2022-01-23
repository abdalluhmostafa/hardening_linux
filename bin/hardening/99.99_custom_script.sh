#!/bin/bash

#
# CIS Debian 7 Hardening
#

#
# Hardening script skeleton replace this line with proper point treated
#

#set -e # One error, it's over
#set -u # One variable unset, it's over
HARDENING_LEVEL=3

# This function will be called if the script status is on enabled / audit mode
audit () {
#set -e
NEWUSER='New-SSH-USER'
USERPUBKEY='SSH-USER-Public-Key'



#if [ -z "$NEWUSER" ]; then
#        echo "Username required"
#        exit 1;
#fi

#if [ -z "$USERPUBKEY" ]; then
#        echo "Public key required - Enclose argument in quotes!"
#        exit 1;
#fi

#1.) Create a new user and add it to wheel group
useradd -d /home/$NEWUSER -s /bin/bash -m $NEWUSER -G wheel


#2.) Create a local public/private key pair as the user.
su - -c "ssh-keygen -q -t rsa -f ~/.ssh/id_rsa -N ''" $NEWUSER



#3.) Create an authorized_keys file with their external public key,
su - -c "echo $USERPUBKEY > .ssh/authorized_keys" $NEWUSER



#4.) Adjust the authorized_keys permissions
su - -c "chmod 600 .ssh/authorized_keys" $NEWUSER



#5.) Allow wheel group im sudoers file 
## it's first search for wheel if it in sudoers didn't make any changes if not it's add it
if ! [[ $(grep '^%wheel*' /etc/sudoers) ]]; then
        echo '%wheel  ALL=(ALL)       NOPASSWD: ALL' >> /etc/sudoers
fi


}

# This function will be called if the script status is on enabled mode
apply () {
set -e
#read -p 'Enter UserName: ' NEWUSER
#read -p 'Enter Your Public Key: ' USERPUBKEY
NEWUSER='New-SSH-USER'
USERPUBKEY='SSH-USER-Public-Key'

#if [ -z "$NEWUSER" ]; then
#        echo "Username required"
#        exit 1;
#fi

#if [ -z "$USERPUBKEY" ]; then
#        echo "Public key required - Enclose argument in quotes!"
#        exit 1;
#fi

#1.) Create a new user and add it to wheel group
useradd -d /home/$NEWUSER -s /bin/bash -m $NEWUSER -G wheel

#2.) Create a local public/private key pair as the user.
su - -c "ssh-keygen -q -t rsa -f ~/.ssh/id_rsa -N ''" $NEWUSER


#3.) Create an authorized_keys file with their external public key,
su - -c "echo $USERPUBKEY > .ssh/authorized_keys" $NEWUSER


#4.) Adjust the authorized_keys permissions
su - -c "chmod 600 .ssh/authorized_keys" $NEWUSER


#5.) Allow wheel group im sudoers file 
## it's first search for wheel if it in sudoers didn't make any changes if not it's add it
if ! [[ $(grep '^%wheel*' /etc/sudoers) ]]; then
        echo '%wheel  ALL=(ALL)       NOPASSWD: ALL' >> /etc/sudoers
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
[ -r "$CIS_ROOT_DIR"/lib/main.sh ] && . $CIS_ROOT_DIR/lib/main.sh

