# Install Dark Ages IV: War & Mythos a mod for Dwarf Fortress

get_dark_description() {
	echo "DarkAges v${CT_DARK_VERSION}"
}
get_dark_credits() {
	echo "GM-X"
}
get_dark_url() {
	echo "http://www.bay12forums.com/smf/index.php?topic=143540.0"
}
get_dark_license() {
	echo -n
}

# Download DF
do_dark_get() {
	CT_GetFile "DarkAges_${CT_DARK_VERSION}" ".zip" \
         ${CT_DARK_DROPBOX_URL}
}

get_dark_dir() {
	echo "${CT_SRC_DIR}/DarkAges_${CT_DARK_VERSION}/"
}


# Extract DA
do_dark_extract() {
	# extract in src dir
	da_dir="$(get_dark_dir)"
	mkdir -p "$da_dir"
	CT_Pushd $da_dir
	CT_Extract nochdir "DarkAges_${CT_DARK_VERSION}"
	CT_DoExecLog ALL find . -iname "*.exe" -or -iname "*.dll" -delete
	CT_Popd
}

# Copy DA mod files over DF
do_dark_build() {
	da_dir="$(get_dark_dir)"
	df_dir=${CT_SRC_DIR}/lnp-${CT_LNP_VERSION}/df_${CT_DF_VERSION}
	if [ -d "$da_dir" ]; then
		CT_DoExecLog ALL rsync -qa "${da_dir}"/raw "${da_dir}"/data "${df_dir}"
	else
		CT_Abort "Dark Ages directory $da_dir not found!"
	fi
}
