#!/bin/sh

dev=$(buildah from alpine:edge)
buildah run "$dev" apk add autoconf automake gcc make musl-dev openssl-dev
buildah config --workingdir /work "$dev"
if [ -d ./posh ] ; then
  git -C posh pull
else
  git clone https://salsa.debian.org/clint/posh.git
fi
if [ ! -r ./configure ] ; then
  autoreconf -i posh
fi
buildah run -v "$PWD/posh:/work" "$dev" sh -c "./configure && make"

prod=$(buildah from alpine:edge)
buildah run "$prod" apk add --no-cache -X http://dl-cdn.alpinelinux.org/alpine/edge/testing rlwrap
buildah run "$prod" apk add --no-cache dash checkbashisms shellcheck
buildah copy "$prod" "$PWD/posh/posh" /usr/bin/posh
buildah config --workingdir /work "$prod"
buildah config --cmd '["/usr/bin/rlwrap","-cmD2", "posh"]' "$prod"
buildah commit --squash --rm "$prod" posix-playground
