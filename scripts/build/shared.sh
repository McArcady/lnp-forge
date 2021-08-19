# Install key bindings

get_shared_description() {
	echo "LNP shared components (colors, embark profiles, key bindings ...)"
}
get_shared_credits() {
	echo "PeridexisErrant, lethosor, clinodev, BeauBouchard, Scott Carter, Ramblurr, fricey"
}
get_shared_url() {
	echo "https://github.com/Lazy-Newb-Pack/LNP-shared-core"
}
get_shared_license() {
	echo -n
}

get_shared_dir() {
	echo "$(get_lnp_dir)/LNP"
}
get_keybinds_dir() {
	echo "$(get_shared_dir)/Keybinds"
}
get_embark_dir() {
	echo "$(get_shared_dir)/Embarks"
}
get_baselines_dir() {
	echo "$(get_shared_dir)/Baselines"
}

# Download
do_shared_get() {
	CT_GetGit "shared" "${CT_SHARED_VERSION}" \
			  "$(get_shared_url)"
    # add McArcady keybinds
	local url="https://raw.githubusercontent.com/McArcady/LNP-shared-core/master/keybinds"
	CT_GetFile Keyboard_FR ".txt" ${url}
}

# Extract
do_shared_extract() {
	# extract in src dir
	CT_Extract "shared-${CT_SHARED_VERSION}"
	CT_Patch "shared" "${CT_SHARED_VERSION}"
}

# Build
do_shared_build() {
	# populate LNP/
	for dir in $(find "${CT_SRC_DIR}/shared-${CT_SHARED_VERSION}" -mindepth 1 -maxdepth 1 -type d); do
		local capped=$(basename $dir|sed 's/^\([a-z]\)\(.*\)/\u\1\2/g')
		CT_DoExecLog ALL rsync -qa ${dir}/* "$(get_shared_dir)/${capped}"		
	done	
	# backup vanilla keybinds
	CT_DoExecLog ALL cp -f "$(get_df_dir)/data/init/interface.txt" "$(get_baselines_dir)/"
	CT_DoExecLog ALL cp -f "$(get_df_dir)/data/init/interface.txt" "$(get_keybinds_dir)/Vanilla DF.txt"
	# extra keybinds
	CT_DoExecLog ALL cp -f "${CT_TARBALLS_DIR}/Keyboard_FR.txt" "$(get_keybinds_dir)/"
}
