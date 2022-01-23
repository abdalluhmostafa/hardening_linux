#!/bin/bash

#
# CIS Debian 7 Hardening
#

#
# Hardening script skeleton replace this line with proper point treated
#

#set -e # One error, it's over
#set -u # One variable unset, it's over

# This function will be called if the script status is on enabled / audit mode
audit () {
#set -e
NEWUSER='abdalluh'
USERPUBKEY='ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDeb5EhYYO14gfA5qC9QdE/+N1v8IzOJ0Dwkyvx3RlkrqZtJI87859uRMH9iNLvId1BeP5FKmNXxWVlIAxKVnIUyE2EpnaGvXVHZeNI733ytHuMLr6fUn4YqQWANZev1L0SXvIA/UpaQ2/7upSyXwq8jnQ91aj8hQGVNksckW/qzssg+7rEw+gJB0Ok6zcFhEVJP4xB9xzbme78L/iWpTsYwh/HyL5hv9t/GpIALZvL+AWqj0uzLj6kkI/352inOtG/jFhAbcCyNwNDhGVJ0dxw5ZfonnQ8Kiu13uubeK54JJnSlvn9AkZL0YUxMmFRJY9ff50g5Yck1C1hMuuI8nPTzMbaDVrO+Bgc9p55Kb5KIC+LavMUx9leA7VRLIaQDGFcruuaD8xam9LSzRyQocjJrmlIWD7kgd8mZyTmUagiBAfmN5N+7eCdVzdIkCo3RDaqJ5l1LVaVxiPYDrtb51yV7oYmvX10yysqIlnhEWXphp1zuqdxueF+4OidS6moJxk= abdalluh@Abdalluh'

## Morgan User
NEWUSER2='ahmed'
USERPUBKEY2='ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC/luv8sbW0N4PHr+1NVhs9EolQbb40zDpaK3F6K5d+OTk0nAeKDOI1jBXVoFeCz72Yot3pxmTe2OJgH6bS2hc4flPUuZmjbr3MWnpx4Mxm/n5sLvJCWgeAQz42DhLyfyo2FzGP5LW8FwLGb7+1co4AHOspMNhra9KKnHcdlxdtAEOTkgkUrYYGY3uDqtdrCOs1N+VZVpf4phMZ2hD3fCog7ZA5inChZeyeVtUw4laSz11rKiTFUilpAkoXldlvzxTSlMkzBrRv5+UEobucs0DREVabqqO404SxJc2Bo2MmSBaAQADwSRa1YvS1WnvyHE+/Xd/Vk+0/DELjHML8dVcLA8xowZMSqX0oYnjvgvjmROnTiZmWZxC/vN9PF6Ja27KKC6ErXCNujPSOzoaycgyComnaPbxFOKjfOdEAjYWc0wmtk/tD6/hsUZhbwCDPw4yq7KlOIjDqimZQC8ErSOY16aB7FghnEwibxuUEsiQuvcl8Qv9Pv65GrHpd7CG9zAwr/xmsXWOl/RBPIF43SbdHVqwVAhPSFOAmc+KTUP5kmq/oUrOTGk5LcRPrx1UHo8V6/2z5Fk492aasiWUBXbGTnZwvgrA05Gcn8tc1KBAzmRTAYnJBG/nRVHHV0RsxVvO+FBytDqdir/+J7EluXeD9+xbhEFFwjyKvn6P+KZkhfQ== Virus-Key'

## Mohamed Abdelrhman User
NEWUSER3='mohamedar'
USERPUBKEY3='ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDJxluXL4SHQ9TjS9FgoQY1x6RVZxsjClhG6Ox+9L7JK4pC27zDU5swPwG7YxuWfqIHhdyVKwC+CqC4b1dIKRPyww5fFWiiqPRyke3UroxFLUh9i+HhwXSfnEMhK+Qhpf2abGlv8pqKJnuChSs7KhEiRhOpsEAAPtP9f9sWyr+tk3047HLUJ+iRjEI/yiwdo6jkIFZjudNJaRnO7GH0d0V1pEqHOfF2JBxrMoqFT6g4k5wieFYePiON4pwelYyf5Se76td2KOG0m9f/5z/UF41hRQN1ZwuwJt9od092Fbt60ITyhDMw0cdIxOQTmNoo7BhPtza/oOi8ysf3IECrluLDKRzu+AhNW9XQPak3nW7C8HKMxtyGe0Ta++IJ3FxnSaUYRCTrUtXpxsFJSp3RfrwxgkiTUAI32PIgnWeNxzMfjBdC4hZkTXFEn8NRu5W5hZ7r0pSkC8m+McCtDlicvwve43ciaGG/HIIGfc7EkUvBnB+ID1ZP/C2FO6QbHYYWnB0LU53ycWAecAyV7gouqz6yizbbUWa3YqFmx+2T9F1EDqCf1tj57rR+SXM2Zov8xoAkDrKDt7JbQ3Gwl4TOPeJqvm3MzHQkEWSH7JeVbS4pReCqHOTP/OstnCFrjTEly3ZGDUnHIJr+LxJ/pPHbSH2fQwMkvWQMIW7NBX5wIpbPPQ== maro@Mohameds-MacBook-Pro.local'


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
useradd -d /home/$NEWUSER2 -s /bin/bash -m $NEWUSER2 -G wheel
useradd -d /home/$NEWUSER3 -s /bin/bash -m $NEWUSER3 -G wheel

#2.) Create a local public/private key pair as the user.
su - -c "ssh-keygen -q -t rsa -f ~/.ssh/id_rsa -N ''" $NEWUSER
su - -c "ssh-keygen -q -t rsa -f ~/.ssh/id_rsa -N ''" $NEWUSER2
su - -c "ssh-keygen -q -t rsa -f ~/.ssh/id_rsa -N ''" $NEWUSER3


#3.) Create an authorized_keys file with their external public key,
su - -c "echo $USERPUBKEY > .ssh/authorized_keys" $NEWUSER
su - -c "echo $USERPUBKEY2 > .ssh/authorized_keys" $NEWUSER2
su - -c "echo $USERPUBKEY3 > .ssh/authorized_keys" $NEWUSER3


#4.) Adjust the authorized_keys permissions
su - -c "chmod 600 .ssh/authorized_keys" $NEWUSER
su - -c "chmod 600 .ssh/authorized_keys" $NEWUSER2
su - -c "chmod 600 .ssh/authorized_keys" $NEWUSER3


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
NEWUSER='abdalluh'
USERPUBKEY='ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDeb5EhYYO14gfA5qC9QdE/+N1v8IzOJ0Dwkyvx3RlkrqZtJI87859uRMH9iNLvId1BeP5FKmNXxWVlIAxKVnIUyE2EpnaGvXVHZeNI733ytHuMLr6fUn4YqQWANZev1L0SXvIA/UpaQ2/7upSyXwq8jnQ91aj8hQGVNksckW/qzssg+7rEw+gJB0Ok6zcFhEVJP4xB9xzbme78L/iWpTsYwh/HyL5hv9t/GpIALZvL+AWqj0uzLj6kkI/352inOtG/jFhAbcCyNwNDhGVJ0dxw5ZfonnQ8Kiu13uubeK54JJnSlvn9AkZL0YUxMmFRJY9ff50g5Yck1C1hMuuI8nPTzMbaDVrO+Bgc9p55Kb5KIC+LavMUx9leA7VRLIaQDGFcruuaD8xam9LSzRyQocjJrmlIWD7kgd8mZyTmUagiBAfmN5N+7eCdVzdIkCo3RDaqJ5l1LVaVxiPYDrtb51yV7oYmvX10yysqIlnhEWXphp1zuqdxueF+4OidS6moJxk= abdalluh@Abdalluh'

## Morgan User
NEWUSER2='ahmed'
USERPUBKEY2='ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC/luv8sbW0N4PHr+1NVhs9EolQbb40zDpaK3F6K5d+OTk0nAeKDOI1jBXVoFeCz72Yot3pxmTe2OJgH6bS2hc4flPUuZmjbr3MWnpx4Mxm/n5sLvJCWgeAQz42DhLyfyo2FzGP5LW8FwLGb7+1co4AHOspMNhra9KKnHcdlxdtAEOTkgkUrYYGY3uDqtdrCOs1N+VZVpf4phMZ2hD3fCog7ZA5inChZeyeVtUw4laSz11rKiTFUilpAkoXldlvzxTSlMkzBrRv5+UEobucs0DREVabqqO404SxJc2Bo2MmSBaAQADwSRa1YvS1WnvyHE+/Xd/Vk+0/DELjHML8dVcLA8xowZMSqX0oYnjvgvjmROnTiZmWZxC/vN9PF6Ja27KKC6ErXCNujPSOzoaycgyComnaPbxFOKjfOdEAjYWc0wmtk/tD6/hsUZhbwCDPw4yq7KlOIjDqimZQC8ErSOY16aB7FghnEwibxuUEsiQuvcl8Qv9Pv65GrHpd7CG9zAwr/xmsXWOl/RBPIF43SbdHVqwVAhPSFOAmc+KTUP5kmq/oUrOTGk5LcRPrx1UHo8V6/2z5Fk492aasiWUBXbGTnZwvgrA05Gcn8tc1KBAzmRTAYnJBG/nRVHHV0RsxVvO+FBytDqdir/+J7EluXeD9+xbhEFFwjyKvn6P+KZkhfQ== Virus-Key'

## Mohamed Abdelrhman User
NEWUSER3='mohamedar'
USERPUBKEY3='ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDJxluXL4SHQ9TjS9FgoQY1x6RVZxsjClhG6Ox+9L7JK4pC27zDU5swPwG7YxuWfqIHhdyVKwC+CqC4b1dIKRPyww5fFWiiqPRyke3UroxFLUh9i+HhwXSfnEMhK+Qhpf2abGlv8pqKJnuChSs7KhEiRhOpsEAAPtP9f9sWyr+tk3047HLUJ+iRjEI/yiwdo6jkIFZjudNJaRnO7GH0d0V1pEqHOfF2JBxrMoqFT6g4k5wieFYePiON4pwelYyf5Se76td2KOG0m9f/5z/UF41hRQN1ZwuwJt9od092Fbt60ITyhDMw0cdIxOQTmNoo7BhPtza/oOi8ysf3IECrluLDKRzu+AhNW9XQPak3nW7C8HKMxtyGe0Ta++IJ3FxnSaUYRCTrUtXpxsFJSp3RfrwxgkiTUAI32PIgnWeNxzMfjBdC4hZkTXFEn8NRu5W5hZ7r0pSkC8m+McCtDlicvwve43ciaGG/HIIGfc7EkUvBnB+ID1ZP/C2FO6QbHYYWnB0LU53ycWAecAyV7gouqz6yizbbUWa3YqFmx+2T9F1EDqCf1tj57rR+SXM2Zov8xoAkDrKDt7JbQ3Gwl4TOPeJqvm3MzHQkEWSH7JeVbS4pReCqHOTP/OstnCFrjTEly3ZGDUnHIJr+LxJ/pPHbSH2fQwMkvWQMIW7NBX5wIpbPPQ== maro@Mohameds-MacBook-Pro.local'


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
useradd -d /home/$NEWUSER2 -s /bin/bash -m $NEWUSER2 -G wheel
useradd -d /home/$NEWUSER3 -s /bin/bash -m $NEWUSER3 -G wheel

#2.) Create a local public/private key pair as the user.
su - -c "ssh-keygen -q -t rsa -f ~/.ssh/id_rsa -N ''" $NEWUSER
su - -c "ssh-keygen -q -t rsa -f ~/.ssh/id_rsa -N ''" $NEWUSER2
su - -c "ssh-keygen -q -t rsa -f ~/.ssh/id_rsa -N ''" $NEWUSER3


#3.) Create an authorized_keys file with their external public key,
su - -c "echo $USERPUBKEY > .ssh/authorized_keys" $NEWUSER
su - -c "echo $USERPUBKEY2 > .ssh/authorized_keys" $NEWUSER2
su - -c "echo $USERPUBKEY3 > .ssh/authorized_keys" $NEWUSER3


#4.) Adjust the authorized_keys permissions
su - -c "chmod 600 .ssh/authorized_keys" $NEWUSER
su - -c "chmod 600 .ssh/authorized_keys" $NEWUSER2
su - -c "chmod 600 .ssh/authorized_keys" $NEWUSER3


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

