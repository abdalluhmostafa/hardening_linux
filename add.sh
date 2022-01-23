set -e
#read -p 'Enter UserName: ' NEWUSER
#read -p 'Enter Your Public Key: ' USERPUBKEY
NEWUSER=ahmed
USERPUBKEY='ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDeb5EhYYO14gfA5qC9QdE/+N1v8IzOJ0Dwkyvx3RlkrqZtJI87859uRMH9iNLvId1BeP5FKmNXxWVlIAxKVnIUyE2EpnaGvXVHZeNI733ytHuMLr6fUn4YqQWANZev1L0SXvIA/UpaQ2/7upSyXwq8jnQ91aj8hQGVNksckW/qzssg+7rEw+gJB0Ok6zcFhEVJP4xB9xzbme78L/iWpTsYwh/HyL5hv9t/GpIALZvL+AWqj0uzLj6kkI/352inOtG/jFhAbcCyNwNDhGVJ0dxw5ZfonnQ8Kiu13uubeK54JJnSlvn9AkZL0YUxMmFRJY9ff50g5Yck1C1hMuuI8nPTzMbaDVrO+Bgc9p55Kb5KIC+LavMUx9leA7VRLIaQDGFcruuaD8xam9LSzRyQocjJrmlIWD7kgd8mZyTmUagiBAfmN5N+7eCdVzdIkCo3RDaqJ5l1LVaVxiPYDrtb51yV7oYmvX10yysqIlnhEWXphp1zuqdxueF+4OidS6moJxk= abdalluh@Abdalluh'


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
