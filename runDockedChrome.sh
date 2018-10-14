#!/bin/bash

docker run \
-it \
--rm \
--name chrome \
--shm-size=1024m \
--cap-add=SYS_ADMIN \
-p=127.0.0.1:4444:4444 \
yukinying/chrome-headless-browser-selenium