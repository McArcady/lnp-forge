# Make package ready for AppImage format

get_appimage_description() {
	echo "AppImage generated with linuxdeploy"
}
get_appimage_credits() {
	echo "TheAssassin"
}
get_appimage_url() {
	# broken version at "https://github.com/linuxdeploy/linuxdeploy/"
	# see https://github.com/linuxdeploy/linuxdeploy/issues/143#issuecomment-671091455
	echo "https://artifacts.assassinate-you.net/linuxdeploy/travis-456/"
}
get_appimage_license() {
	echo -n
}

get_appimage_dir() {
	echo -n
}

# Download appImage of linuxdeploy
do_appimage_get() {
    CT_GetFile "linuxdeploy-x86_64" ".AppImage" \
               "$(get_appimage_url)/"
	CT_DoExecLog ALL chmod +x ${CT_TARBALLS_DIR}/linuxdeploy-x86_64.AppImage
}

do_appimage_extract() {
	# Nothing to do
	echo -n
}

do_appimage_build() {	
	# install metadata
	lnp_dir="$(get_lnp_dir)"
	icon_dir="/usr/share/icons/hicolor/256x256/apps"
	prefix="com.bay12forums.linuxdwarfpack"
	CT_DoExecLog ALL mkdir -p ${lnp_dir}/usr/share/metainfo
	CT_DoExecLog ALL cp appimage/${prefix}.appdata.xml ${lnp_dir}/usr/share/metainfo/
	CT_DoExecLog ALL mkdir -p ${lnp_dir}/usr/share/applications
	CT_DoExecLog ALL cp appimage/${prefix}.desktop  ${lnp_dir}/usr/share/applications/
	CT_DoExecLog ALL mkdir -p ${lnp_dir}${icon_dir}
	CT_DoExecLog ALL cp appimage/linux-dwarf-pack.png ${lnp_dir}${icon_dir}/
	CT_DoExecLog ALL cp appimage/linux-dwarf-pack.sh ${lnp_dir}/

	# fix appdata
	all_licenses=""
	for _step in ${CT_STEPS}; do
		var=CT_$(echo ${_step} | tr 'a-z' 'A-Z')
		eval val=\$"$var"
		if [ "${val}" = "y" ]; then
			descr=$(get_${_step}_description)
			license=$(get_${_step}_license)
			if [ "${license}" != "" ]; then
				printf -v all_licenses "${all_licenses}${descr}: ${license} / "
			fi
		fi
	done
	dat=$(date +%d-%m-%Y)
	# escaping for xml
	all_licenses=$(echo "${all_licenses}" | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g; s/"/\&quot;/g; s/'"'"'/\&#39;/g')
	# escaping for regex replacement
	all_licenses=$(echo "${all_licenses}" | sed 's/&/\\\&/g;')
	echo $all_licenses
	CT_DoExecLog ALL sed -i -e 's|%VERSION%|'"${CT_VERSION}"'|g'   \
				 -e 's|%DATE%|'"${dat}"'|g'                        \
				 -e 's|%LICENSE%|'"${all_licenses}"'|g'            \
				 ${lnp_dir}/usr/share/metainfo/${prefix}.appdata.xml
	CT_DoExecLog ALL sed -i                                        \
				 -e 's|%EXEC%|'"linux-dwarf-pack.sh"'|g'           \
				 -e 's|%ICON%|'"linux-dwarf-pack"'|g'              \
				 ${lnp_dir}/usr/share/applications/${prefix}.desktop

	# generate AppImage
	CT_DoExecLog ALL ARCH=x86_64 VERSION=${CT_VERSION} ${CT_TARBALLS_DIR}/linuxdeploy-x86_64.AppImage \
				 --output appimage                                \
				 --appdir ${lnp_dir}                              \
				 --custom-apprun ${lnp_dir}/linux-dwarf-pack.sh   \
				 --icon-file=${lnp_dir}${icon_dir}/linux-dwarf-pack.png      \
				 --desktop-file=${lnp_dir}/usr/share/applications/${prefix}.desktop
}
