#!/bin/sh
ROOT_DIR=/tmp/appi
USER_DIR=~/.lnp/

callTerm() {
  fusermount -zu ${ROOT_DIR}
  echo "${ROOT_DIR} unmounted."
  exit 0
}
trap callTerm TERM INT

echo "creating overlay of ${USER_DIR} and ${APPDIR} in ${ROOT_DIR}..."
UID=$(id -u)
GID=$(id -g)
mkdir -p ${ROOT_DIR} ${USER_DIR} && unionfs -o cow,uid=${UID},gid=${GID} ${USER_DIR}=RW:${APPDIR} ${ROOT_DIR}

cd ${ROOT_DIR}
./startlnp.sh
callTerm
