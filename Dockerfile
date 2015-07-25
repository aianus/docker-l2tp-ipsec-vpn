FROM ubuntu:trusty
MAINTAINER Alex Ianus <hire@alexianus.com>
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y curl xl2tpd supervisor libnss3-dev libnspr4-dev pkg-config libpam0g-dev libcap-ng-dev libcap-ng-utils libselinux1-dev libcurl4-nss-dev libgmp3-dev flex bison gcc make libunbound-dev libnss3-tools
# IPSec
RUN mkdir -p /opt/src
WORKDIR /opt/src
RUN curl -s https://download.libreswan.org/libreswan-3.13.tar.gz | tar xvz > /dev/null
WORKDIR /opt/src/libreswan-3.13
RUN make programs
RUN make install

COPY ipsec.conf /etc/ipsec.conf
COPY ipsec.secrets /etc/ipsec.secrets
COPY xl2tpd.conf /etc/xl2tpd/xl2tpd.conf
COPY chap-secrets /etc/ppp/chap-secrets
COPY start_vpn.sh /usr/bin

EXPOSE 500/udp 4500/udp 1701/udp

ENTRYPOINT ["start_vpn.sh"]
