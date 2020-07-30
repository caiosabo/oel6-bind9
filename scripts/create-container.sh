#!/bin/bash
#
# Caio Sabo <caiosabo@gmail.com>

if [ -z "$1" ]; then
    echo "Error - argument <container name> is required";
    exit 1;
fi;
CONTNAME=${1};
MY_DOCKER0_IP=$(ip -4 addr show docker0 | egrep -o "inet ([0-9]+)(\.[0-9]+){3}" | cut -d" " -f2);

# --security-opt apparmor:unconfined

HOST_BASEDIR="/home/casabo/git-projects/caiosabo/oel6-bind9";

DOCKER_PORTS="-p ${MY_DOCKER0_IP}:53:53 -p ${MY_DOCKER0_IP}:53:53/udp";
#DOCKER_PORTS="-p 192.168.145.1:53:53 -p 192.168.145.1:53:53/udp -p 172.17.0.1:53:53 -p 172.17.0.1:53:53/udp";
#DOCKER_NETWORK="--network 192.168.145.0/24"
DOCKER_DNS="--dns=127.0.0.1 --dns-search=oracle.in";
DOCKER_VOLUME00="-v ${HOST_BASEDIR}/etc/named.conf:/etc/named.conf";
DOCKER_VOLUME01="-v ${HOST_BASEDIR}/etc/named.rfc1912.zones:/etc/named.rfc1912.zones";
DOCKER_VOLUME02="-v ${HOST_BASEDIR}/var/named/oracle.in.zone:/var/named/oracle.in.zone";
DOCKER_VOLUME03="-v ${HOST_BASEDIR}/var/named/oracle.in.revzone:/var/named/oracle.in.revzone";
DOCKER_VOLUMES="${DOCKER_VOLUME00} ${DOCKER_VOLUME01} ${DOCKER_VOLUME02} ${DOCKER_VOLUME03}";
DOCKER_ENV="-e TZ=America/Sao_Paulo";
DOCKER_SPECIAL_ARGS="--cap-add=SYS_ADMIN --security-opt apparmor:unconfined";
DOCKER_NAME="--name ${CONTNAME} --hostname ${CONTNAME}";
#DOCKER_IMAGE="local-oel6-bind9:2.8";
DOCKER_IMAGE="caiosabo/oel6-bind9-auto:master";
DOCKER_COMMAND="/bin/bash";

# Create a new container with volume
CMD="docker run -it -d ${DOCKER_PORTS} ${DOCKER_DNS} ${DOCKER_VOLUMES} ${DOCKER_ENV} ${DOCKER_SPECIAL_ARGS} ${DOCKER_NAME} ${DOCKER_IMAGE} ${DOCKER_COMMAND}"

# Create a new container with bind9
#CMD="docker run -it -d ${DOCKER_PORTS} ${DOCKER_DNS} ${DOCKER_ENV} ${DOCKER_SPECIAL_ARGS} ${DOCKER_NAME} ${DOCKER_IMAGE} ${DOCKER_COMMAND}";

echo ${CMD};
${CMD}

docker exec -it ${CONTNAME} /etc/init.d/named start
