# Build .xz (Arch) package

get_arch_description() {
	echo "Arch package generated with FPM"
}
get_arch_credits() {
	echo $(get_fpm_credits)
}
get_arch_url() {
	echo $(get_fpm_url)
}
get_arch_license() {
	echo -n
}
get_arch_dir() {
	echo -n
}
do_arch_get() {
	echo -n
}
do_arch_extract() {
	echo -n
}

do_arch_build() {
	do_fpm_build "pacman" \
				 "sdl2_image sdl2_ttf xterm python tk qt5-base unionfs-fuse gtk2" \
				 "--pacman-compression bzip2 --version $(echo ${CT_VERSION}|sed 's/-/./g')"
}
