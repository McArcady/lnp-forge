# Install graphics

get_graphics_dir() {
	echo "$(get_lnp_dir)/LNP/Graphics"
}

# Download
do_graphics_get() {
    # DFGraphics set from Github
	CT_GetGit "graphics" "${CT_GRAPHICS_VERSION}" \
			  https://github.com/McArcady/DFgraphics.git
}

# Extract
do_graphics_extract() {
	# extract in src dir
	CT_Extract "graphics-${CT_GRAPHICS_VERSION}"
}

# Build
do_graphics_build() {
	CT_Pushd "$(get_lnp_dir)/LNP"
    # copy to DF dir
	CT_DoExecLog ALL rm -fr Graphics
	CT_DoExecLog ALL cp -fR "${CT_SRC_DIR}/graphics-${CT_GRAPHICS_VERSION}/graphics-packs" "Graphics"
	# patch manifests
	sed -i -e 's/\"df_min_version\": \".*\"/\"df_min_version\": \"0.00"/g' -e 's/\"df_max_version\": \".*\"/\"df_max_version\": \"1.00"/g' Graphics/*/manifest.json
	CT_Popd
}
