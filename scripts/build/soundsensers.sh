# Install SoundSense-RS

get_soundsensers_description() {
	echo "Soundsense-RS ${CT_SOUNDSENSERS_VERSION}"
}
get_soundsensers_credits() {
	echo "prixt"
}
get_soundsensers_url() {
	echo "https://github.com/prixt/soundsense-rs"
}
get_soundsensers_license() {
	echo "MIT License"
}

# Download
do_soundsensers_get() {
	# https://github.com/prixt/soundsense-rs/releases/download/v1.5.1/soundsense-rs-v1.5.1-linux
    CT_GetGit "soundsense-rs" "${CT_SOUNDSENSERS_VERSION}" \
               "$(get_soundsensers_url).git"
}

# Extract
do_soundsensers_extract() {
	echo
	CT_Extract "soundsense-rs-${CT_SOUNDSENSERS_VERSION}"
	CT_Patch "soundsense-rs" "${CT_SOUNDSENSERS_VERSION}"
}

# Build
do_soundsensers_build() {

	soundsensers_src_dir="${CT_SRC_DIR}/soundsense-rs-${CT_SOUNDSENSERS_VERSION}"
	CT_Pushd "$soundsensers_src_dir"
	cargo build --release --locked
	dist_dir="$(get_lnp_dir)/soundsense-rs"
	script="$(get_lnp_dir)/LNP/Utilities/SoundSense-RS.sh"
	exe_name="soundsense-rs"
#	
#    # copy to DF dir
	CT_DoExecLog ALL mkdir -p "${dist_dir}"
	CT_DoExecLog ALL rsync -qa "$soundsensers_src_dir/target/release/${exe_name}" "${dist_dir}"
	CT_DoExecLog ALL chmod +x ${dist_dir}/${exe_name}
#	
#	# fix start script
	CT_DoExecLog ALL rm -f "${script}"
	echo "#!/bin/sh" > ${script}
	echo "cd ../../soundsense-rs" >> ${script}
	echo "exec ./${exe_name} --gamelog ../df_${CT_DF_VERSION}/gamelog.txt" >> ${script}
	CT_DoExecLog ALL chmod +x "${script}"
#	
#	# add description
	echo "[SoundSense-RS.sh:SoundSense-RS:Tool that parses game logs and reacts to game events with sound effects, incidental music and dwarfy comments]" >> "$(get_lnp_dir)/LNP/Utilities/utilities.txt"
	CT_Popd
}
