#!/usr/bin/env bash

NODEJS_VERSION=$(grep '^FROM node' Dockerfile  | cut -d ':' -f 2)
IMAGE_VERSION=$(cat VERSION)

GIT_TAG="v${NODEJS_VERSION}-${IMAGE_VERSION}"

GIT_TAG_BODY=$(cat <<-TAG_BODY
Node.js version: ${NODEJS_VERSION}
Image version: ${IMAGE_VERSION}

TAG_BODY
)

echo "Creating git tag: ${GIT_TAG} ..." &&
git tag -a -m "${GIT_TAG_BODY}" "${GIT_TAG}" &&

echo "Pushing tag to Github ..." &&
git push origin ${GIT_TAG} &&
echo "Done."
