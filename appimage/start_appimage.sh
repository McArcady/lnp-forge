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

if [ -z "${APPIMAGE}" ] || [ -z "${APPDIR}" ]; then
  echo "env APPIMAGE or APPDIR is undefined!"
  echo "This script is intended to be run from an AppImage."
  exit 1
fi
echo
echo "Starting "$(basename ${APPIMAGE} | sed 's/.AppImage//g')
echo "- configuration and game saves are stored in "$(echo ${USER_DIR})
echo "- feedback or issues? see http://www.bay12forums.com/smf/index.php?topic=157712"
echo "- created with lnp-forge: https://github.com/McArcady/lnp-forge"
echo

if ! unionfs --version > /dev/null 2>&1; then
  echo "Missing package unionfs/unionfs-fuse!"
  echo "Aborted."
  exit 1
fi
echo "Creating overlay of ${USER_DIR} and ${APPDIR} in ${ROOT_DIR}..."
myUID=$(id -u)
myGID=$(id -g)
mkdir -p ${ROOT_DIR} ${USER_DIR}
if ! unionfs -o cow,uid=${myUID},gid=${myGID} ${USER_DIR}=RW:${APPDIR} ${ROOT_DIR}; then
  echo "Failed to mount overlay, check your install of unionfs/unionfs-fuse."
  echo "Aborted."
  exit 1
fi

cd ${ROOT_DIR}
./startlnp.sh

callTerm
