# Build .apk (Alpine) package

get_alpine_description() {
	echo "Alpine package generated with FPM"
}
get_alpine_credits() {
	echo $(get_fpm_credits)
}
get_alpine_url() {
	echo $(get_fpm_url)
}
get_alpine_license() {
	echo -n
}
get_alpine_dir() {
	echo -n
}
do_alpine_get() {
	echo -n
}
do_alpine_extract() {
	echo -n
}

do_alpine_build() {
	do_fpm_build "apk" "sdl2_image sdl2_ttf openal-soft libsndfile xterm python3-tkinter py3-distutils-extra py3-pillow qt5-qtdeclarative unionfs-fuse libcanberra-gtk3" \
				 "--version $(echo ${CT_VERSION}|sed 's/_/-/g') --architecture x86_64"
}
