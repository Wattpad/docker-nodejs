#!/usr/bin/env bash

NODEJS_VERSION=$(grep '^ENV NODEJS_VERSION' Dockerfile  | cut -d '=' -f 2 | sed 's/^v//')
ALPINE_VERSION=$(grep '^FROM alpine' Dockerfile  | cut -d ':' -f 2 )
IMAGE_VERSION=$(cat VERSION)

GIT_TAG="v${IMAGE_VERSION}-node${NODEJS_VERSION}-alpine${ALPINE_VERSION}"

GIT_TAG_BODY=$(cat <<-TAG_BODY
Release v${IMAGE_VERSION}

Node.js version: ${NODEJS_VERSION}
Alpine version: ${ALPINE_VERSION}
TAG_BODY
)

echo "Creating git tag: ${GIT_TAG} ..." &&
git tag -a -m "${GIT_TAG_BODY}" "${GIT_TAG}" &&

echo "Pushing tag to Github ..." &&
git push origin ${GIT_TAG} &&
echo "Done."
