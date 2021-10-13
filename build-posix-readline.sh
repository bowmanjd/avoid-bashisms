#!/bin/sh

cont=$(buildah from debian:stable-slim)
buildah run "$cont" apt-get -qq update
# buildah run "$cont" apt-get -q -y upgrade
buildah run "$cont" env DEBIAN_FRONTEND=noninteractive apt-get -qq install posh rlfe
buildah config --workingdir /work "$cont"
#buildah config --cmd "posh" "$cont"
#buildah config --cmd '["/usr/bin/rlfe", "posh"]' "$cont"
buildah config --cmd '' "$cont" # to forego warnings
buildah config --entrypoint '["/usr/bin/rlfe"]' "$cont"
buildah config --cmd '["posh"]' "$cont"
buildah commit --squash --rm "$cont" posix-readline
