# Build .deb (Debian) package

get_debian_description() {
	echo "Debian package generated with FPM"
}
get_debian_credits() {
	echo $(get_fpm_credits)
}
get_debian_url() {
	echo $(get_fpm_url)
}
get_debian_license() {
	echo -n
}
get_debian_dir() {
	echo -n
}
do_debian_get() {
	echo -n
}
do_debian_extract() {
	echo -n
}

do_debian_build() {
	do_fpm_build "deb" "libsdl-image1.2 libsdl-ttf2.0-0 gnome-terminal openjdk-8-jre python3-tk qt5-default unionfs-fuse"
}
