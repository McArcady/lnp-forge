# Build .deb package

get_debian_description() {
	echo "Debian package generated with FPM"
}
get_debian_credits() {
	echo "Jordan Sissel"
}
get_debian_url() {
	echo "https://https://github.com/jordansissel/fpm"
}
get_debian_license() {
	echo -n
}
get_debian_dir() {
	echo -n
}
do_debian_get() {
	# Nothing to do
	echo -n
}
do_debian_extract() {
	# Nothing to do
	echo -n
}

do_debian_build() {
	arch="x86_64"
	lnp_dir="$(get_lnp_dir)"
	name="linux-dwarf-pack"
	depends="libsdl-image1.2 libsdl-ttf2.0-0 gnome-terminal openjdk-8-jre python3-tk qt5-default"
	depends=$(echo ${depends}|sed 's/ / \-d /g')
	dist_dir="/opt/${name}"
	CT_DoExecLog ALL cp "appimage/start_appimage.sh" "${lnp_dir}/LinuxDwarfPack.sh"
	CT_DoExecLog ALL fpm -s dir -t deb -n ${name}          \
				 --force                                   \
				 --depends ${depends}                      \
				 --prefix ${dist_dir}                      \
				 --chdir ${lnp_dir}                        \
				 --version ${CT_VERSION}                   \
				 --architecture ${arch}                    \
				 --maintainer "<McArcady@gihub.com>"       \
				 --vendor "bay12forums.com"                \
				 --url "http://www.bay12forums.com/smf/index.php?topic=157712"      \
				 --description "A simple ready-to-play Dwarf Fortress starter pack" \
				 --license "mixed (see ${dist_dir}/PRAISE_THE_MODDERS)"             \

}
