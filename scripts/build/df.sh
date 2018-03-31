# Install DwarfFortress

get_df_description() {
	echo "DwarfFortress v${CT_DF_VERSION}"
}
get_df_credits() {
	echo "Tarn and Zach Adams"
}
get_df_url() {
	echo "http://www.bay12games.com/dwarves/"
}

get_df_dir() {
	echo "$(get_lnp_dir)/df_${CT_DF_VERSION}"
}

# Download DF
do_df_get() {
    if [ "${CT_DF_CUSTOM}" = "y" ]; then
        CT_GetCustom "df" "${CT_DF_VERSION}" "${CT_DF_CUSTOM_LOCATION}"
    else
        # official DF.
		# e.g http://www.bay12games.com/dwarves/df_42_06_linux.tar.bz2
        CT_GetFile "df_${CT_DF_VERSION}" ".tar.bz2" \
                   http://www.bay12games.com/dwarves/
    fi # ! custom location
}

# Extract DF
do_df_extract() {
	# extract in src dir
    CT_Extract "df_${CT_DF_VERSION}"
}

do_df_build() {
    # copy to DF dir
	CT_DoExecLog ALL rsync -qa "${CT_SRC_DIR}/df_${CT_DF_VERSION}" "$(get_lnp_dir)"

    # If using custom directory location, nothing to do
    if [ "${CT_DF_CUSTOM}" = "y"                    \
         -a -d "${CT_SRC_DIR}/df_${CT_DF_VERSION}" ]; then
        return 0
    fi
	lnp_dir=${CT_SRC_DIR}/lnp-${CT_LNP_VERSION}/
	df_dir=df_${CT_DF_VERSION}
	if [ -d "$lnp_dir" ]; then
		CT_Pushd "$(get_lnp_dir)"
		# Extract in LNP dir
		CT_Extract nochdir "${df_dir}"
		# Save default init files
		CT_DoExecLog ALL mkdir -p "LNP/Defaults"
		CT_DoExecLog ALL cp -f "${df_dir}/data/init/init.txt" "LNP/Defaults/"
		CT_DoExecLog ALL cp -f "${df_dir}/data/init/d_init.txt" "LNP/Defaults/"
		# Generate baselines
		bl_dir="$(get_baselines_dir)/"$(echo "${df_dir}"|sed s/_linux//g)
		CT_DoExecLog ALL mkdir -p "${bl_dir}"
		CT_DoExecLog ALL cp -fr "${df_dir}/data" "${bl_dir}"
		CT_DoExecLog ALL cp -fr "${df_dir}/raw" "${bl_dir}"
		CT_DoExecLog ALL cp -fr "${df_dir}/sdl" "${bl_dir}"
		CT_Popd
	else
		CT_Abort "LNP directory $lnp_dir not found!"
	fi
}
