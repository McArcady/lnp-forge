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
	if ! fusermount -zu ${ROOT_DIR} 2>/dev/null; then
		if ! pkill -nf ${ROOT_DIR}; then
			echo "Failed to unmount ${ROOT_DIR}!"
			echo "Please unmount it manually with 'fusermount -u ${ROOT_DIR}'."
		fi
	fi
	echo "${ROOT_DIR} unmounted."
	# wait a little for the unionfs process to end
	sleep 0.1 && rmdir ${ROOT_DIR}
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

myUID=$(id -u)
myGID=$(id -g)
if ! unionfs --version > /dev/null 2>&1; then
  if ! fuse-overlayfs --version > /dev/null 2>&1; then
    echo "Missing package unionfs/unionfs-fuse or fuse-overlayfs!"
    echo "Aborted."
    rmdir ${ROOT_DIR}
    exit 1
  else
    # workdir shall be in same fs as upperdir
    mkdir -p ${HOME}/tmp
    UNIONFS="fuse-overlayfs -o squash_to_uid=${myUID},squash_to_gid=${myGID},upperdir=${USER_DIR},lowerdir=${APPDIR},workdir=${HOME}/tmp ${ROOT_DIR}"
  fi
else
  UNIONFS="unionfs -o cow,auto_unmount,uid=${myUID},gid=${myGID} ${USER_DIR}=RW:${APPDIR} ${ROOT_DIR}"
fi

echo "Creating overlay of ${USER_DIR} and ${APPDIR} in ${ROOT_DIR}..."
mkdir -p ${ROOT_DIR} ${USER_DIR}
if ! $( ${UNIONFS} ); then
  echo "Failed to mount overlay, check your install of unionfs/unionfs-fuse or fuse-overlayfs."
  echo "Aborted."
  exit 1
fi

cd ${ROOT_DIR}
./startlnp.sh

callTerm
