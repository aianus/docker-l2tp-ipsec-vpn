#!/bin/sh

IP_ADDRESS=`/sbin/ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}'`
: ${ACCOUNT_NAME=student}
: ${PASSWORD=howdyhowdy}
sed -i "s/YOUR.SERVER.IP.ADDRESS/$IP_ADDRESS/g" /etc/ipsec.conf /etc/ipsec.secrets
sed -i "s/{ACCOUNT_NAME}/$ACCOUNT_NAME/g" /etc/ppp/chap-secrets
sed -i "s/{PASSWORD}/$PASSWORD/g" /etc/ppp/chap-secrets /etc/ipsec.secrets

echo "Disabling the IPSec and XL2TP auto start..."

/usr/sbin/service ipsec stop
/usr/sbin/service xl2tpd stop

update-rc.d -f xl2tpd remove
update-rc.d -f ipsec remove

echo "Adding the new auto start..."

update-rc.d ipsec-assist defaults

echo "Starting up the VPN..."

/usr/sbin/service ipsec-assist start

echo "Done."
