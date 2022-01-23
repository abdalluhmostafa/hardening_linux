set -e
#read -p 'Enter UserName: ' NEWUSER
#read -p 'Enter Your Public Key: ' USERPUBKEY
NEWUSER=USER-SSH
USERPUBKEY='KEY-SSH'


if [ -z "$NEWUSER" ]; then
        echo "Username required"
        exit 1;
fi

if [ -z "$USERPUBKEY" ]; then
        echo "Public key required - Enclose argument in quotes!"
        exit 1;
fi

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
