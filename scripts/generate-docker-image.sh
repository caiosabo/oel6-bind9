#!/bin/bash
# Caio Sabo <caiosabo@gmail.com>

CONTAINER_BASE="dns01";
NEW_VERSION="1.1";

docker stop ${CONTAINER_BASE}
docker container commit ${CONTAINER_BASE} oel6-bind9:${ǸEW_VERSION}
docker tag oel6-bind9:1.0 caiosabo/oel6-bind9:${ǸEW_VERSION}
docker push caiosabo/oel6-bind9:${ǸEW_VERSION}

