# Install DFHack plugin TextWillBeText

# Download
do_twbt_get() {
    # official TWBT from Github
	CT_GetGit "twbt" "${CT_TWBT_VERSION}" \
			  https://github.com/mifki/df-twbt.git
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
