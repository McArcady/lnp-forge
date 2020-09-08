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
	do_fpm_build "rpm"
}
