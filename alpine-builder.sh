#!/bin/sh

dev=$(buildah from alpine:edge)
buildah run "$dev" apk add autoconf automake gcc make musl-dev openssl-dev
buildah config --workingdir /work "$dev"
# buildah config --cmd '' "$dev" # to forego warnings
#buildah config --entrypoint '["/usr/bin/rlwrap","-cmD2"]' "$dev"
buildah commit --squash --rm "$dev" alpine-builder

