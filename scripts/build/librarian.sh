# Install DFHack script 'The Librarian'

get_librarian_description() {
	echo "The Librarian"
}
get_librarian_credits() {
	echo "PatrikLundell"
}

get_librarian_url() {
	echo "https://github.com/PatrikLundell/scripts/raw/own_scripts/"
}
get_librarian_license() {
	echo -n
}

do_librarian_get() {
    CT_GetFile "librarian" ".lua" "$(get_librarian_url)"
}

do_librarian_extract() {
	dfhack_scripts_dir=${CT_SRC_DIR}/dfhack-${CT_DFHACK_VERSION}/scripts	
	CT_DoExecLog ALL cp -f "${CT_TARBALLS_DIR}/librarian.lua" "${dfhack_scripts_dir}/"
}

do_librarian_build() {
	echo -n
}
