# This file adds the functions to download graphic packages
# Licensed under the GPL v2. See COPYING in the root of this package

get_graphics_dir() {
	echo "$(get_lnp_dir)/LNP/Graphics"
}

# Download
do_graphics_get() {
	if [ "${CT_GRAPHICS_VERSION}" = "" ]; then
		export CT_GRAPHICS_VERSION="${CT_GRAPHICS_REV}"
	fi
    # DFGraphics set from Github
	CT_GetGit "graphics" "${CT_GRAPHICS_VERSION}" \
			  https://github.com/DFgraphics/DFgraphics.git
}

# Extract
do_graphics_extract() {
	# Nothing to do
	echo -n
}

# Extract
do_graphics_build() {
	CT_Pushd "$(get_lnp_dir)/LNP"
	CT_Extract nochdir "graphics-${CT_GRAPHICS_VERSION}"
	CT_DoExecLog ALL rm -fr Graphics
	CT_DoExecLog ALL ln -s "graphics-${CT_GRAPHICS_VERSION}" Graphics
	CT_DoLog INFO "Patching DFGraphics manifests to allow use with DF-${CT_DF_VERSION}"
	sed -i -e 's/\"df_min_version\": \".*\"/\"df_min_version\": \"0.00"/g' -e 's/\"df_max_version\": \".*\"/\"df_max_version\": \"1.00"/g' Graphics/*/manifest.json
	CT_Popd
}
