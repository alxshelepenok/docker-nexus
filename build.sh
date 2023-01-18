#!/bin/bash

set -ex
IMAGE_NAME="waterscape/nexus"
NEXUS_REPOSITORY="nexus.docker-hosted.wtrscape.com"
TAG="${1}"
docker build -t ${IMAGE_NAME}:"${TAG}" .
docker tag ${IMAGE_NAME}:"${TAG}" ${NEXUS_REPOSITORY}/${IMAGE_NAME}:"${TAG}"
docker push ${NEXUS_REPOSITORY}/${IMAGE_NAME}:"${TAG}"
