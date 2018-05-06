# Install embark profiles

get_embark_description() {
	echo "Embark profiles"
}
get_embark_credits() {
	echo "clinodev"
}
get_embark_url() {
	echo "https://raw.githubusercontent.com/Lazy-Newb-Pack/LNP-shared-core"
}

get_embark_dir() {
	echo "$(get_lnp_dir)/LNP/Embarks"
}

# Download
do_embark_get() {
    # captain_duck: http://pastebin.com/raw/4uiSfu8V
	# clinodev: http://pastebin.com/raw/FRT4hpkJ
	for kb in advanced_profiles default_profiles starting_scenarios tutorial_profiles; do
		CT_GetFile ${kb} ".txt" "$(get_embark_url)/master/embarks/"
	done
}

# Extract
do_embark_extract() {
	# Nothing to do
	echo -n
}

# Build
do_embark_build() {
	for kb in advanced_profiles default_profiles starting_scenarios tutorial_profiles; do
		CT_DoExecLog ALL cp -f "${CT_TARBALLS_DIR}/${kb}.txt" "$(get_embark_dir)/"
	done
}
