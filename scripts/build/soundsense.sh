# Install SoundSense

get_soundsense_description() {
	echo "Soundsense ${CT_SOUNDSENSE_VERSION}"
}
get_soundsense_credits() {
	echo ""
}
get_soundsense_url() {
	echo "http://df.zweistein.cz/soundsense"
}
get_soundsense_license() {
	echo "GNU GPL v3"
}

get_soundsense_dir() {
	echo "$(get_df_dir)/soundsense"
}

# Download
do_soundsense_get() {
    # official package: http://df.zweistein.cz/soundsense/soundSense_2015-1_194.zip
    CT_GetFile "soundSense_${CT_SOUNDSENSE_VERSION}" ".zip" \
               "$(get_soundsense_url)"
}

# Extract
do_soundsense_extract() {
	# extract in src dir
    CT_Extract "soundSense_${CT_SOUNDSENSE_VERSION}"
}

# Build
do_soundsense_build() {
    # copy to DF dir
	CT_DoExecLog ALL rsync -qa "${CT_SRC_DIR}/soundsense" "$(get_df_dir)"

	# fix link for LNP
	script="$(get_lnp_dir)/LNP/Utilities/SoundSense.sh"
	CT_DoExecLog ALL dos2unix "$(get_soundsense_dir)/soundSense.sh"
	CT_DoExecLog ALL chmod +x "$(get_soundsense_dir)/soundSense.sh"
	echo "#!/bin/sh" > ${script}
	echo "cd ../../df_${CT_DF_VERSION}/soundsense" >> ${script}
	echo "./soundSense.sh" >> ${script}
	CT_DoExecLog ALL chmod +x "${script}"
	
	# add description
	echo "[SoundSense.sh:SoundSense:Tool that parses game logs and reacts to game events with sound effects, incidental music and dwarfy comments]" >> "$(get_lnp_dir)/LNP/Utilities/utilities.txt"
}
