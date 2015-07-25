#!/bin/sh

IP_ADDRESS=`/sbin/ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}'`
: ${ACCOUNT_NAME=student}
: ${PASSWORD=howdyhowdy}
sed -i "s/YOUR.SERVER.IP.ADDRESS/$IP_ADDRESS/g" /etc/ipsec.conf /etc/ipsec.secrets
sed -i "s/{ACCOUNT_NAME}/$ACCOUNT_NAME/g" /etc/ppp/chap-secrets
sed -i "s/{PASSWORD}/$PASSWORD/g" /etc/ppp/chap-secrets /etc/ipsec.secrets
service ipsec restart
