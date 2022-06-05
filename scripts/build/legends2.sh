# Install Legends Browser 2

get_legends2_description() {
	echo "LegendsBrowser2 v${CT_LEGENDS2_VERSION}"
}
get_legends2_credits() {
	echo "Robert Janetzko"
}
get_legends2_url() {
	echo "https://github.com/robertjanetzko/LegendsBrowser2"
}
get_legends2_license() {
	echo "Copyright (c) 2022 Robert Janetzko - MIT License"
}

get_legends2_dir() {
	echo "$(get_lnp_dir)"
}

# Download
do_legends2_get() {
    # official package from https://github.com/robertjanetzko/LegendsBrowser2/releases
	subdir=${CT_LEGENDS2_VERSION}
	case ${CT_LEGENDS2_VERSION} in *.0)
		# strip last '.0'
		subdir=${CT_LEGENDS2_VERSION%??}
	esac
    CT_GetFile "legendsbrowser-${CT_LEGENDS2_VERSION}-linux" ".zip" \
               "$(get_legends2_url)/releases/download/${subdir}"
}

# Extract
do_legends2_extract() {
	# extract in src dir
	CT_Extract "legendsbrowser-${CT_LEGENDS2_VERSION}-linux"
}

# Build
do_legends2_build() {
	dist_dir="$(get_lnp_dir)/LNP/Utilities"
	script="${dist_dir}/LegendsBrowser2.sh"
	exe_name="legendsbrowser"

	# copy to LNP dir
	CT_DoExecLog ALL rsync -qa "${CT_SRC_DIR}/${exe_name}" "$(get_lnp_dir)"
	CT_DoExecLog ALL chmod +x "$(get_lnp_dir)/${exe_name}"
	
	# fix start script
	echo "#!/bin/sh" > ${script}
	echo "cd ../../" >> ${script}
	echo "exec legendsbrowser" >> ${script}
	CT_DoExecLog ALL chmod +x "${script}"
	
	# add description
	echo "[LegendsBrowser2.sh:Legends Browser 2:Web-based legends viewer]" >> ${dist_dir}/utilities.txt
}
