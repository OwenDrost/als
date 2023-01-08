#!/bin/bash
TIMEOUT=120
TOKEN="$1"

php81 /app/utilities/check_token.php $TOKEN
if [ $? -ne 0 ];then
    echo "Invalid token, Please restart session"
    exit 1
fi;

echo "Your session will logout in $TIMEOUT seconds"
cd /mnt/fakeroot
env -i PATH="/mnt/fakebin" HOME="/mnt/fakeroot" PWD="/mnt/fakeroot" \
    /sbin/runuser -u r00t -- /bin/bash -c "unset LOGNAME && unset USER && export PS1=\"[root@localhost ~]# \" && export TERM=\"$TERM\" && ulimit -u 20 && /usr/bin/timeout -s 9 $TIMEOUT /bin/rbash"