# Install graphics

get_graphics_description() {
	echo "Graphics tilesets"
}
get_graphics_credits() {
	echo "claireanlage, fricy, jecowa, Mayday, Meph, sv-esk"
}
get_graphics_url() {
	echo "https://github.com/McArcady/DFgraphics.git"
}
get_graphics_license() {
	echo -n
}

get_graphics_dir() {
	echo "$(get_lnp_dir)/LNP/Graphics"
}

# Download
do_graphics_get() {
    # DFGraphics set from Github
	CT_GetGit "graphics" "${CT_GRAPHICS_VERSION}" \
			  "$(get_graphics_url)"
}

# Extract
do_graphics_extract() {
	# extract and patch in src dir
	CT_Extract "graphics-${CT_GRAPHICS_VERSION}"
	CT_Patch "graphics" "${CT_GRAPHICS_VERSION}"
}

# Build
do_graphics_build() {
	CT_Pushd "$(get_lnp_dir)/LNP"
    # copy to DF dir
	CT_DoExecLog ALL rm -fr Graphics
	CT_DoExecLog ALL cp -fR "${CT_SRC_DIR}/graphics-${CT_GRAPHICS_VERSION}/graphics-packs" "Graphics"
	# patch manifests
	sed -i -e 's/\"df_min_version\": \".*\"/\"df_min_version\": \"0.00"/g' -e 's/\"df_max_version\": \".*\"/\"df_max_version\": \"1.00"/g' Graphics/*/manifest.json

        # Build TWBT variants
        for dir in Graphics/*; do
          if [ ! -d "${dir}" ]; then
            continue
          fi

          can_twbt=0
          for x in data/twbt_init data/twbt_art raw/twbt_graphics raw/twbt_objects; do
            if [ -d "${dir}/${x}" ]; then
              can_twbt=1
            fi
          done

          if [ "${can_twbt}" = 0 ]; then
            continue
          fi

          dir_twbt="${dir}-TWBT"

          CT_DoExecLog ALL cp -fR "${dir}" "${dir_twbt}"

          if [ -d "${dir_twbt}/data/twbt_art" ]; then
            CT_DoExecLog ALL cp -fR "${dir_twbt}"/data/twbt_art/* "${dir_twbt}"/data/art/
            CT_DoExecLog ALL rm -rf "${dir_twbt}/data/twbt_art"
          fi

          if [ -d "${dir_twbt}/data/twbt_init" ]; then
            CT_DoExecLog ALL cp -fR "${dir_twbt}"/data/twbt_init/* "${dir_twbt}"/data/init/
            CT_DoExecLog ALL rm -rf "${dir_twbt}/data/twbt_init"
          fi

          if [ -d "${dir_twbt}/raw/twbt_graphics" ]; then
            CT_DoExecLog ALL cp -fR "${dir_twbt}"/raw/twbt_graphics/* "${dir_twbt}"/raw/graphics/
            CT_DoExecLog ALL rm -rf "${dir_twbt}/raw/twbt_graphics"
          fi

          if [ -d "${dir_twbt}/raw/twbt_objects" ]; then
            CT_DoExecLog ALL cp -fR "${dir_twbt}"/raw/twbt_objects/* "${dir_twbt}"/raw/objects/
            CT_DoExecLog ALL rm -rf "${dir_twbt}/raw/twbt_objects"
          fi

          CT_DoExecLog ALL sed -r -i -e 's!"folder_prefix": "([^"]+)"!"folder_prefix": "\1-TWBT"!' "${dir_twbt}/manifest.json"
          CT_DoExecLog ALL sed -r -i -e 's!"title": "([^"]+)"!"title": "\1 (TWBT)"!' "${dir_twbt}/manifest.json"
          CT_DoExecLog ALL sed -r -i -e 's!"tooltip": "([^"]+)"!"tooltip": "\1 Requires TWBT."!' "${dir_twbt}/manifest.json"
        done

	CT_Popd
}
