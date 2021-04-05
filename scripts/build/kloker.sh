# Install DFHack plugin Kloker

get_kloker_description() {
	echo "Kloker (ex-Cavern Keeper) v${CT_KLOKER_VERSION}"
}
get_kloker_credits() {
	echo "Andrew Strain"
}
get_kloker_url() {
	echo "https://github.com/strainer/cavekeeperdf"
}
get_kloker_license() {
	echo
}

# Download
do_kloker_get() {
    # official Kloker from Github
	CT_GetGit "kloker" "${CT_KLOKER_VERSION}" \
			  "$(get_kloker_url)"
}

# Extract
do_kloker_extract() {
	kloker_src_dir="${CT_SRC_DIR}/kloker-${CT_KLOKER_VERSION}"
	dfhack_plugins_dir=${CT_SRC_DIR}/dfhack-${CT_DFHACK_VERSION}/plugins
	if [ -d "$dfhack_plugins_dir" ]; then
		# extract archived git repo
		CT_Extract "kloker-${CT_KLOKER_VERSION}"
		# patch
		CT_Patch "kloker" "${CT_KLOKER_VERSION}"
		# copy kloker.cpp to dfhack plugins
		CT_DoExecLog ALL rsync -qa ${kloker_src_dir}/plugins/* ${dfhack_plugins_dir}
	else
		CT_Abort "DFHack plugins directory $dfhack_plugins_dir not found!"
	fi
}

do_kloker_build() {
	kloker_src_dir="${CT_SRC_DIR}/kloker-${CT_KLOKER_VERSION}"
	kloker_dist_dir="${CT_SRC_DIR}/lnp-${CT_LNP_VERSION}/df_${CT_DF_VERSION}/kloker"
	# colors
	CT_DoExecLog ALL mkdir -p ${kloker_dist_dir}
	CT_DoExecLog ALL cp -f ${kloker_src_dir}/dfkeeper_pallete.txt ${kloker_dist_dir}/ || :
#	CT_DoExecLog ALL cp -f "${kloker_src_dir}/colors.txt" "${df_dir}" || :
}
