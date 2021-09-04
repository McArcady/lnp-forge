# Install Legends Browser

get_legends_description() {
	echo "LegendsBrowser v${CT_LEGENDS_VERSION}"
}
get_legends_credits() {
	echo "Robert Janetzko"
}
get_legends_url() {
	echo "https://github.com/robertjanetzko/LegendsBrowser"
}
get_legends_license() {
	echo "Copyright (c) 2015 Robert Janetzko - MIT License"
}
get_legends_spdx() {
	echo "MIT"
}

get_legends_dir() {
	echo "$(get_lnp_dir)"
}

# Download
do_legends_get() {
    # official package from https://github.com/robertjanetzko/LegendsBrowser/releases
	subdir=${CT_LEGENDS_VERSION}
	case ${CT_LEGENDS_VERSION} in *.0)
		# strip last '.0'
		subdir=${CT_LEGENDS_VERSION%??}
	esac
    CT_GetFile "legendsbrowser-${CT_LEGENDS_VERSION}" ".jar" \
               "$(get_legends_url)/releases/download/${subdir}"
}

# Extract
do_legends_extract() {
	# Nothing to do
	echo -n
}

# Build
do_legends_build() {
	dist_dir="$(get_lnp_dir)/LNP/Utilities"
	script="${dist_dir}/LegendsBrowser.sh"
	jarname="legendsbrowser-${CT_LEGENDS_VERSION}.jar"
	
	# fix start script
	CT_DoExecLog ALL cp -f "${CT_TARBALLS_DIR}/${jarname}" "$(get_legends_dir)/"
	echo "#!/bin/sh" > ${script}
	echo "cd ../../" >> ${script}
	echo "exec java -jar ${jarname}" >> ${script}
	CT_DoExecLog ALL chmod +x "${script}"

	# conf file
	echo "root=df_${CT_DF_VERSION}" > "$(get_lnp_dir)/legendsbrowser.properties"
	
	# add description
	echo "[LegendsBrowser.sh:Legends Browser:Web-based legends viewer]" >> ${dist_dir}/utilities.txt
}
