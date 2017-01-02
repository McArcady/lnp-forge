# Install DFHack

# Download
do_dfhack_get() {
    # official DFHack from Github
	CT_GetGit "dfhack" "${CT_DFHACK_VERSION}" \
			  https://github.com/DFHack/dfhack.git
}

# Extract
do_dfhack_extract() {
	# extract archived git repo
    CT_Extract "dfhack-${CT_DFHACK_VERSION}"
	# patch
	CT_Patch "dfhack" "${CT_DFHACK_VERSION}"
}

# Build
do_dfhack_build() {
	dfhack_src_dir="${CT_SRC_DIR}/dfhack-${CT_DFHACK_VERSION}"
	df_dir=${CT_SRC_DIR}/lnp-${CT_LNP_VERSION}/df_${CT_DF_VERSION}

	# 64-bit compile?
	if [ "${CT_DFHACK_VERSION}" \> "0.43.05" ]; then
		extra_args=" -DDFHACK_BUILD_ARCH=64"
	else
		extra_args=" -DBUILD_STONESENSE=1"
	fi
	
	CT_Pushd "${dfhack_src_dir}/build"
    CT_DoExecLog ALL cmake .. -DCMAKE_BUILD_TYPE:string=Release -DCMAKE_INSTALL_PREFIX=${df_dir} ${extra_args}
	CT_DoExecLog ALL make ${JOBSFLAGS} install
	CT_DoExecLog ALL rm -f "${df_dir}/libs/libstdc++.so.6"
 	CT_Popd
}

