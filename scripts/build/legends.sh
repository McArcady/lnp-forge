# Install Legends Browser

get_legends_dir() {
	echo "$(get_lnp_dir)"
}

# Download
do_legends_get() {
    # official package from https://github.com/robertjanetzko/LegendsBrowser/releases
    CT_GetFile "legendsbrowser-${CT_LEGENDS_VERSION}" ".jar" \
               "https://github.com/robertjanetzko/LegendsBrowser/releases/download/${CT_LEGENDS_VERSION}"
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
