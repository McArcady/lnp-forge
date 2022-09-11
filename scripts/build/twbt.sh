# Install DFHack plugin TextWillBeText

get_twbt_description() {
	echo "TWBT ${CT_TWBT_VERSION}"
}
get_twbt_credits() {
	echo "Vitaly Pronkin, nshcat, indivisible, thurin"
}
get_twbt_url() {
#	echo "https://github.com/mifki/df-twbt.git"
	echo "https://github.com/thurin/df-twbt.git"
}
get_twbt_license() {
	echo -n
}

# Download
do_twbt_get() {
    # official TWBT from Github
	CT_GetGit "twbt" "${CT_TWBT_VERSION}" \
			  "$(get_twbt_url)"
}

# Extract
do_twbt_extract() {
	dfhack_plugins_dir=${CT_SRC_DIR}/dfhack-${CT_DFHACK_VERSION}/plugins
	if [ -d "$dfhack_plugins_dir" ]; then
		# extract TWBT to dfhack plugins
		CT_Pushd $dfhack_plugins_dir
		CT_Extract nochdir "twbt-${CT_TWBT_VERSION}"
		CT_DoExecLog ALL rm -f twbt
		CT_DoExecLog ALL ln -s twbt-${CT_TWBT_VERSION} twbt
		# patch
		CT_Patch nochdir "twbt" "${CT_TWBT_VERSION}"
		# activate
		if grep --quiet --invert-match twbt ${dfhack_plugins_dir}/CMakeLists.custom.txt; then
			echo "add_subdirectory(twbt)" >> ${dfhack_plugins_dir}/CMakeLists.custom.txt
		fi
		CT_Popd
	else
		CT_Abort "DFHack plugins directory $dfhack_plugins_dir not found!"
	fi
}

do_twbt_build() {
	twbt_dist_dir=${CT_SRC_DIR}/dfhack-${CT_DFHACK_VERSION}/plugins/twbt/dist
	df_art_dir=${CT_SRC_DIR}/lnp-${CT_LNP_VERSION}/df_${CT_DF_VERSION}/data/art/
	# copy art
	CT_DoExecLog ALL cp -f "${twbt_dist_dir}/white1px.png" "${df_art_dir}" || :
	CT_DoExecLog ALL cp -f "${twbt_dist_dir}/transparent1px.png" "${df_art_dir}" || :
}
