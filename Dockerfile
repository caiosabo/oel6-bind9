#
# Docker image: caiosabo/oel6-bind9-chroot:1.0
#

FROM oraclelinux:6.10
MAINTAINER Caio Sabo <caiosabo@gmail.com>
#TAG local-oel6-bind9:2.4

RUN yum install bind-chroot bind-utils wget -y && \
    yum clean all && \
    rndc-confgen -a && \
    chmod 640 /etc/rndc.key && \
    chown root:named /etc/rndc.key

ADD --chown=named:named etc/named.conf /etc/named.conf
ADD --chown=named:named etc/named.rfc1912.zones /etc/named.rfc1912.zones
ADD --chown=named:named var/named/oracle.in.zone /var/named/oracle.in.zone
ADD --chown=named:named var/named/oracle.in.revzone /var/named/oracle.in.revzone

# EXPOSE 53 53/udp
# EXPOSE 192.168.145.1:53/tcp 192.168.145.1:53/udp
# VOLUME ["/var/bind"]
HEALTHCHECK CMD ["rndc", "status"]
CMD ["service", "named", "start"]
