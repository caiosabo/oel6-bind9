#!/bin/bash

docker build -t local-oel6-bind9:2.8 .

# next step
# $ ./create-container.sh dns01

# next step
# $ docker stop dns01


# next step
# $ docker container commit dns01 local-oel6-bind9

# next step
# $ docker tag local-oel6-bind9 caiosabo/oel6-bind9:1.3


# next step
# $ docker push caiosabo/oel6-bind9:1.3
