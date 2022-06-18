# Install DFHack script 'Biome Manipulator'

get_biome_description() {
	echo "Biome Manipulator"
}
get_biome_credits() {
	echo "PatrikLundell"
}
get_biome_url() {
	echo "https://github.com/PatrikLundell/scripts/raw/own_scripts/"
}
get_biome_license() {
	echo -n
}

do_biome_get() {
    CT_GetFile "biomemanipulator" ".lua" "$(get_biome_url)"
}

do_biome_extract() {
	dfhack_scripts_dir=${CT_SRC_DIR}/dfhack-${CT_DFHACK_VERSION}/scripts	
	CT_DoExecLog ALL cp -f "${CT_TARBALLS_DIR}/biomemanipulator.lua" "${dfhack_scripts_dir}/"
}

do_biome_build() {
	echo -n
}
