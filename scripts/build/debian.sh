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
get_debian_dependencies() {
	echo "libsdl-image1.2 libsdl-ttf2.0-0 libopenal1 libsndfile1 gnome-terminal openjdk-11-jre python3-tk python3-distutils python3-pil.imagetk libqt5qml5 libqt5concurrent5 libqt5gui5 unionfs-fuse libcanberra-gtk-module"
}
get_debian_build_dependencies() {
	echo "libxml-libxml-perl libxml-xslt-perl libxml-filter-xslt-perl mercurial help2man git openjdk-11-jre libncurses5-dev zlib1g-dev lib32z1-dev mesa-common-dev gcc-multilib g++-multilib cmake dos2unix tcl autoconf gperf bison flex gawk libtool libsdl-dev libsdl-image1.2 libsdl-ttf2.0-0 texinfo ninja-build qt5-qmake qttools5-dev-tools qt5-default libqt5svg5-dev qt5-image-formats-plugins qtbase5-dev qtdeclarative5-dev python3-tk libasound2-dev libgtk-3-dev libwebkit2gtk-4.0-dev cargo gperf"
}
do_debian_build() {
	do_fpm_build "deb" "libsdl-image1.2 libsdl-ttf2.0-0 libopenal1 libsndfile1 gnome-terminal openjdk-11-jre python3-tk python3-distutils python3-pil.imagetk libqt5qml5 libqt5concurrent5 libqt5gui5 unionfs-fuse libcanberra-gtk-module"
}
