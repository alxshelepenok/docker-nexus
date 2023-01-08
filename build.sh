#!/bin/bash

set -ex
IMAGE_NAME="waterscape/nexus"
TAG="${1}"
docker build -t ${IMAGE_NAME}:"${TAG}" .
