# Install DFHack

get_dfhack_description() {
	echo "DFHack v${CT_DFHACK_VERSION}"
}
get_dfhack_credits() {
	echo "lethosor, JapaMala, BenLubar"
}
get_dfhack_url() {
	echo "https://github.com/DFHack/dfhack.git"
}

# Download
do_dfhack_get() {
    # official DFHack from Github
	CT_GetGit "dfhack" "${CT_DFHACK_VERSION}" \
			  "$(get_dfhack_url)"
}

# Extract
do_dfhack_extract() {
	dfhack_src_dir="${CT_SRC_DIR}/dfhack-${CT_DFHACK_VERSION}"
	# extract archived git repo
    CT_Extract "dfhack-${CT_DFHACK_VERSION}"
	# patch
	CT_Patch "dfhack" "${CT_DFHACK_VERSION}"
	# generate git-describe.h
	CT_Pushd "${dfhack_src_dir}"
	echo > library/git-describe.cmake
	echo "#define DFHACK_GIT_DESCRIPTION \"${CT_DFHACK_VERSION}\"" > library/include/git-describe.h
	echo "#define DFHACK_GIT_COMMIT \"${CT_DFHACK_VERSION}\"" >> library/include/git-describe.h
	echo "#define DFHACK_GIT_XML_COMMIT \"${CT_DFHACK_VERSION}\"" >> library/include/git-describe.h
	echo "#define DFHACK_GIT_XML_EXPECTED_COMMIT \"${CT_DFHACK_VERSION}\"" >> library/include/git-describe.h
 	CT_Popd
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
    CT_DoExecLog ALL cmake .. -G Ninja -DCMAKE_BUILD_TYPE:string=Release -DCMAKE_INSTALL_PREFIX=${df_dir} ${extra_args}
	# patch git-related constants
	echo "#define DFHACK_BUILD_ID \"\"" >> ../library/include/git-describe.h
	echo "#define DFHACK_GIT_TAGGED"    >> ../library/include/git-describe.h
	echo "#define DFHACK_GIT_XML_MATCH" >> ../library/include/git-describe.h
	CT_DoExecLog ALL ninja -j5 install
	CT_DoExecLog ALL rm -f "${df_dir}/libs/libstdc++.so.6"
	CT_DoExecLog ALL cp -f "${df_dir}/dfhack.init-example" "${df_dir}/dfhack.init"
 	CT_Popd
}
