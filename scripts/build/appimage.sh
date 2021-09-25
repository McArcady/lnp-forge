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

# Download linuxdeploy
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
	#echo $all_licenses
	CT_DoExecLog ALL sed -i -e 's|%VERSION%|'"${CT_VERSION}"'|g'   \
				 -e 's|%DATE%|'"${dat}"'|g'                        \
				 -e 's|%LICENSE%|'"${all_licenses}"'|g'            \
				 ${lnp_dir}/usr/share/metainfo/${prefix}.appdata.xml
	CT_DoExecLog ALL sed -i                                        \
				 -e 's|%EXEC%|'"linux-dwarf-pack.sh"'|g'           \
				 -e 's|%ICON%|'"linux-dwarf-pack"'|g'              \
				 ${lnp_dir}/usr/share/applications/${prefix}.desktop

	ldpath=""
	if [ "${CT_APPIMAGE_WITH_DEPENDENCIES}" = "y" ]; then
		if ! command -v apt -v &> /dev/null; then
			CT_Abort "'apt' not found - requires a Debian/Ubuntu system"
		fi
		# download all dependencies
		dldir="depdebs"
		CT_DoExecLog ALL mkdir -p ${dldir}
		CT_Pushd ${dldir}
		deps=$(apt-rdepends $(get_debian_dependencies) |grep -v "^ " |sort)
		# hidden dependency
		deps="${deps} freeglut3"
		for _dep in ${deps}; do
			# downloadable file?
			if apt-cache show ${_dep}|grep -q Filename; then
				CT_DoExecLog ALL apt-get download ${_dep}
			fi
		done
		CT_Popd
		# extract each deb file
		for _deb in $(ls ${dldir}/*.deb); do
			CT_DoExecLog ALL dpkg --extract "${_deb}" ${lnp_dir}
		done
		# remove troublesome .desktop files
		CT_DoExecLog ALL find ${lnp_dir} -type f -name '*.desktop' |grep -v ${prefix} |xargs rm --force
		# patch LD_PATH for linuxdeploy
		ldpath="${lnp_dir}/usr/lib/jvm/java-11-openjdk-amd64/lib/server:${lnp_dir}/usr/lib/x86_64-linux-gnu:${lnp_dir}/usr/lib/cdebconf"
	fi

	# generate AppImage
	CT_DoExecLog ALL ARCH=x86_64 VERSION=${CT_VERSION} LD_LIBRARY_PATH=${ldpath} ${CT_TARBALLS_DIR}/linuxdeploy-x86_64.AppImage \
				 --output appimage                                \
				 --appdir ${lnp_dir}                              \
				 --custom-apprun ${lnp_dir}/linux-dwarf-pack.sh   \
				 --icon-file=${lnp_dir}${icon_dir}/linux-dwarf-pack.png      \
				 --desktop-file=${lnp_dir}/usr/share/applications/${prefix}.desktop
}
