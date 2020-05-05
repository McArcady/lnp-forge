# Install the LazyNewbPack

get_lnp_description() {
	echo "LazyNewbPack interface v${CT_LNP_VERSION}"
}
get_lnp_credits() {
	echo "Michael Madsen"
}
get_lnp_url() {
	echo "https://github.com/Pidgeot/python-lnp"
}

get_lnp_dir() {
	echo "${CT_SRC_DIR}/lnp-${CT_LNP_VERSION}"
}

# Download
do_lnp_get() {
    # official python-LNP
	# https://bitbucket.org/Pidgeot/python-lnp
	CT_GetGit "lnp" "${CT_LNP_VERSION}" \
			 "$(get_lnp_url)"
}

# Extract
do_lnp_extract() {
	# extract archived git repo
    CT_Extract "lnp-${CT_LNP_VERSION}"
	# patch
	CT_Patch "lnp" "${CT_LNP_VERSION}"
}

do_lnp_build() {
	util_dir="$(get_lnp_dir)/LNP/Utilities"
	CT_DoExecLog ALL mkdir -p "${util_dir}"
	CT_DoExecLog ALL mkdir -p "$(get_keybinds_dir)"
	CT_DoExecLog ALL mkdir -p "$(get_embark_dir)"
	CT_DoExecLog ALL mkdir -p "$(get_baselines_dir)"
	# Clean-up
	CT_DoExecLog ALL rm -f "${util_dir}/utilities.txt"
	# Script
	CT_DoExecLog ALL chmod +x "$(get_lnp_dir)/startlnp.sh"
}
