# This file adds the function to install DF package
# Copyright 2007 Yann E. MORIN
# Licensed under the GPL v2. See COPYING in the root of this package

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
		# CT_DoExecLog ALL rm -f df_linux
		# CT_DoExecLog ALL ln -s df_${CT_DF_VERSION} df_linux
		# Save default init files
		CT_DoExecLog ALL mkdir -p "LNP/Defaults"
		CT_DoExecLog ALL cp -f "${df_dir}/data/init/init.txt" "LNP/Defaults/"
		CT_DoExecLog ALL cp -f "${df_dir}/data/init/d_init.txt" "LNP/Defaults/"
		CT_Popd
	else
		CT_Abort "LNP directory $lnp_dir not found!"
	fi
}

do_df_build() {
	# Nothing to do
	echo -n
}
