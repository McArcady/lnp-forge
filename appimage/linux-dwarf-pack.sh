#!/bin/sh
ROOT_DIR=$(mktemp -d -t lnp-XXXXXX)

# select dir for conf & data
XDG_DIR=~/.local/share/linux-dwarf-pack
DOT_DIR=~/.lnp
if [ ! -d "${XDG_DIR}" ]; then
	if [ -d "${DOT_DIR}" ]; then
		mv ${DOT_DIR} ${XDG_DIR} || (echo "Failed to move ${DOT_DIR} to ${XDG_DIR}!"; exit 1)
		echo "Transfered data and conf from ${DOT_DIR} to ${XDG_DIR}."
	else
		mkdir -p ${XDG_DIR} || (echo "Failed to create ${XDG_DIR}!"; exit 1)
		echo "Created ${XDG_DIR}."
	fi
fi
USER_DIR=${XDG_DIR}

callTerm() {
  fusermount -zu ${ROOT_DIR}
  echo "${ROOT_DIR} unmounted."
  rmdir ${ROOT_DIR}
  exit 0
}
trap callTerm TERM INT

if [ -z "${APPDIR}" ]; then
	APPDIR="/opt/linux-dwarf-pack"
fi
if [ -z "${APPIMAGE}" ]; then
	PKGNAME="LinuxDwarfPack"
else
	PKGNAME=$(basename ${APPIMAGE} | sed 's/.AppImage//g')	
fi

echo
echo "Starting ${PKGNAME}"
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
