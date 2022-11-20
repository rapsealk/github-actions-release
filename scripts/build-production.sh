#!/bin/bash
export RELEASE_VERSION=$(cat ./VERSION)
echo $RELEASE_VERSION

cp docker-compose.yml docker-compose.prod.yml
sed -i "s/\${RELEASE_VERSION}/${RELEASE_VERSION}/" docker-compose.prod.yml   #--quiet

docker-compose -f docker-compose.yml build

docker save -o "xxxx-${RELEASE_VERSION}-amd64.tar" \
    "xxxx/django:${RELEASE_VERSION}" \
    "xxxx/postgres:${RELEASE_VERSION}" \
    "xxxx/nginx:${RELEASE_VERSION}"

tar -cf xxxx-$RELEASE_VERSION-amd64.release.tar xxxx-$RELEASE_VERSION-amd64.tar docker-compose.prod.yml sample.env
gzip -9 xxxx-$RELEASE_VERSION-amd64.release.tar
