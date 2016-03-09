# This file adds the functions to download graphic packages
# Licensed under the GPL v2. See COPYING in the root of this package

# Download
do_graphics_get() {
	if [ "${CT_DFGRAPHICS_VERSION}" = "" ]; then
		export CT_DFGRAPHICS_VERSION="${CT_DFGRAPHICS_REV}"
	fi
    # DFGraphics set from Github
	CT_GetGit "dfgraphics" "${CT_DFGRAPHICS_VERSION}" \
			  https://github.com/DFgraphics/DFgraphics.git
	
	# if [ "${CT_IRONHAND}" = "y" ]; then
	# 	do_ironhand_get
	# fi
	# if [ "${CT_PHOEBUS}" = "y" ]; then
	# 	do_phoebus_get
	# fi	
}

# Extract
do_graphics_extract() {
	lnp_dir=${CT_SRC_DIR}/lnp-${CT_LNP_VERSION}/LNP
	if [ -d "$lnp_dir" ]; then
		cd $lnp_dir
		CT_Extract nochdir "dfgraphics-${CT_DFGRAPHICS_VERSION}"
		CT_DoExecLog ALL rm -fr Graphics
		CT_DoExecLog ALL ln -s "dfgraphics-${CT_DFGRAPHICS_VERSION}" Graphics
		if [ "${CT_DFGRAPHICS_REV}" != "" ]; then
			CT_DoLog INFO "Patching DFGraphics manifests to allow use with DF-${CT_DF_VERSION}"
			sed -i -e 's/\"df_min_version\": \".*\"/\"df_min_version\": \"0.00"/g' -e 's/\"df_max_version\": \".*\"/\"df_max_version\": \"1.00"/g' Graphics/*/manifest.json
		fi
		cd -
	else
		CT_Abort "LNP directory $lnp_dir not found!"
	fi
}

do_ironhand_get() {
	# http://dffd.bay12games.com/download.php?id=8747&f=Ironhand_40_24A.zip
    CT_GetFile "Ironhand_${CT_IRONHAND_VERSION}" ".zip" \
               "http://dffd.bay12games.com/download.php?id=8747&f="
}

do_phoebus_get() {
	# http://dffd.bay12games.com/download.php?id=2430&f=Phoebus_40_24v00.zip
    CT_GetFile "Phoebus_${CT_PHOEBUS_VERSION}" ".zip" \
               "http://dffd.bay12games.com/download.php?id=2430&f="
}
