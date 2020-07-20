#!/bin/sh
ROOT_DIR=$(mktemp -d -t lnp-XXXXXX)
USER_DIR=~/.lnp/

callTerm() {
  fusermount -zu ${ROOT_DIR}
  echo "${ROOT_DIR} unmounted."
  rmdir ${ROOT_DIR}
  exit 0
}
trap callTerm TERM INT

echo
echo "Starting "$(basename ${APPIMAGE} | sed 's/.AppImage//g')
echo "- configuration and game saves are stored in "$(echo ${USER_DIR})
echo "- feedback or issues? see http://www.bay12forums.com/smf/index.php?topic=157712"
echo "- created with lnp-forge: https://github.com/McArcady/lnp-forge"
echo

echo "Creating overlay of ${USER_DIR} and ${APPDIR} in ${ROOT_DIR}..."
UID=$(id -u)
GID=$(id -g)
mkdir -p ${ROOT_DIR} ${USER_DIR} && unionfs -o cow,uid=${UID},gid=${GID} ${USER_DIR}=RW:${APPDIR} ${ROOT_DIR}

cd ${ROOT_DIR}
./startlnp.sh

callTerm
