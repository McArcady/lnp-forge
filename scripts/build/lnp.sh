# This file adds the function to install LNP package
# Copyright 2007 Yann E. MORIN
# Licensed under the GPL v2. See COPYING in the root of this package

get_lnp_dir() {
	echo "${CT_SRC_DIR}/lnp-${CT_LNP_VERSION}"
}

# Download
do_lnp_get() {
    # official python-LNP
	# https://bitbucket.org/Pidgeot/python-lnp
	CT_GetHG "lnp" "${CT_LNP_VERSION}" \
			 https://bitbucket.org/Pidgeot/python-lnp
}

# Extract
do_lnp_extract() {
	# extract archived git repo
    CT_Extract "lnp-${CT_LNP_VERSION}"
	# set DF folder
	CT_Patch "lnp" "${CT_LNP_VERSION}"		
}

do_lnp_build() {
	util_dir="$(get_lnp_dir)/LNP/Utilities"
	CT_DoExecLog ALL mkdir -p "${util_dir}"
	CT_DoExecLog ALL mkdir -p "$(get_lnp_dir)/LNP/Keybinds"
	# Clean-up
	CT_DoExecLog ALL rm -f "${util_dir}/utilities.txt"
}
