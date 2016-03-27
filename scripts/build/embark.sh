# Install embark profiles

get_embark_dir() {
	echo "$(get_lnp_dir)/LNP/Embarks"
}

# Download
do_embark_get() {
    # captain_duck: http://pastebin.com/raw/4uiSfu8V
	# clinodev: http://pastebin.com/raw/FRT4hpkJ
    CT_GetFile "embark_profiles" ".txt" "https://raw.githubusercontent.com/Lazy-Newb-Pack/LNP-shared-core/master/defaults/"
}

# Extract
do_embark_extract() {
	# Nothing to do
	echo -n
}

# Build
do_embark_build() {
	CT_DoExecLog ALL cp -f "${CT_TARBALLS_DIR}/embark_profiles.txt" "$(get_embark_dir)/"
}
