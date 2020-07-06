#!/bin/sh
set -e
set -x

if [ $(grep -ci $CUPS_USER_ADMIN /etc/shadow) -eq 0 ]; then
    useradd $CUPS_ADMIN --system -G root,lpadmin --no-create-home --password $(mkpasswd $CUPS_ADMIN_PASSWORD)
fi

exec /usr/sbin/cupsd -f
