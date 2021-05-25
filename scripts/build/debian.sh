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
	do_fpm_build "deb" "libsdl-image1.2 libsdl-ttf2.0-0 libopenal1 libsndfile1 gnome-terminal openjdk-11-jre python3-tk python3-distutils python3-pil.imagetk libqt5qml5 libqt5concurrent5 libqt5gui5 unionfs-fuse libcanberra-gtk-module"
}
