# Build package using FPM

get_fpm_description() {
	echo "Package generated with FPM"
}
get_fpm_credits() {
	echo "Jordan Sissel"
}
get_fpm_url() {
	echo "https://github.com/jordansissel/fpm"
}
get_fpm_license() {
	echo -n
}
get_fpm_dir() {
	echo -n
}
do_fpm_get() {
	echo -n
}
do_fpm_extract() {
	echo -n
}

do_fpm_build() {
	# add permissions RX for some dirs
	lnp_dir="$(get_lnp_dir)"
	CT_DoExecLog ALL find ${lnp_dir} -type d \! -perm /o+rx -exec chmod a+rx "{}" \;
	
	# install scripts and stuff
	name="linux-dwarf-pack"
	dist_dir="/opt/${name}"
	icon_dir="/usr/share/icons/hicolor/256x256/apps"
	prefix="com.bay12forums.linuxdwarfpack"
	CT_DoExecLog ALL cp appimage/linux-dwarf-pack.sh ${lnp_dir}/
	CT_DoExecLog ALL cp appimage/linux-dwarf-pack.png ${lnp_dir}/
	CT_DoExecLog ALL cp appimage/${prefix}.desktop ${lnp_dir}/
	CT_DoExecLog ALL sed -i                                            \
				 -e 's|%EXEC%|'"${dist_dir}/linux-dwarf-pack.sh"'|g'   \
				 -e 's|%ICON%|'"${dist_dir}/linux-dwarf-pack.png"'|g'  \
				 ${lnp_dir}/${prefix}.desktop

	# post-install
	script="${lnp_dir}/post-install.sh"
	echo "#!/bin/sh" > ${script}
	echo "mv ${dist_dir}/${prefix}.desktop /usr/share/applications/" >> ${script}
#	echo "mv ${dist_dir}/linux-dwarf-pack.png ${icon_dir}/linux-dwarf-pack.png" >> ${script}

	# pre-uninstall
	script="${lnp_dir}/pre-uninstall.sh"
	echo "#!/bin/sh" > ${script}
	echo "rm -f /usr/share/applications/${prefix}.desktop" >> ${script}
#	echo "rm -f ${icon_dir}/linux-dwarf-pack.png" >> ${script}

	# build pkg
	arch="x86_64"
	depends=$(echo $2|sed 's/ / \-d /g')
	CT_DoExecLog ALL ${FPM} -s dir -t $1 -n ${name}        \
				 --force                                   \
				 --depends ${depends}                      \
				 --prefix ${dist_dir}                      \
				 --chdir ${lnp_dir}                        \
				 --version ${CT_VERSION}                   \
				 --maintainer "<McArcady@github.com>"      \
				 --vendor "www.bay12forums.com"            \
				 --url "http://www.bay12forums.com/smf/index.php?topic=157712"      \
				 --description "A simple ready-to-play Dwarf Fortress starter pack" \
				 --license "mixed (see ${dist_dir}/PRAISE_THE_MODDERS)"             \
				 --after-install ${lnp_dir}/post-install.sh    \
				 --before-remove ${lnp_dir}/pre-uninstall.sh   \
				 $3

}
