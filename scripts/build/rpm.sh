# Build .rpm (Redhat/Fedora) package

get_rpm_description() {
	echo "Rpm package generated with FPM"
}
get_rpm_credits() {
	echo $(get_fpm_credits)
}
get_rpm_url() {
	echo $(get_fpm_url)
}
get_rpm_license() {
	echo -n
}
get_rpm_dir() {
	echo -n
}
do_rpm_get() {
	echo -n
}
do_rpm_extract() {
	echo -n
}

do_rpm_build() {
	do_fpm_build "rpm" "SDL SDL_image SDL_ttf openal-soft alsa-lib alsa-plugins-pulseaudio mesa-dri-drivers mesa-libGLU xterm java-11-openjdk python3-tkinter qt5-qttools python3-pillow-tk fuse-overlayfs" \
				 "--version $(echo ${CT_VERSION}|sed 's/-/_/g') --architecture x86_64"
}
