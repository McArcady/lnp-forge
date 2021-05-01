# Install Legends Browser

get_announcement_description() {
	echo "Announcement Window ${CT_ANNOUNCEMENT_VERSION}"
}
get_announcement_credits() {
	echo "BrachystochroneSD"
}
get_announcement_url() {
	echo "https://github.com/BrachystochroneSD/AnnouncementWindow"
}
get_announcement_license() {
	echo -n
}

get_announcement_dir() {
	echo "$(get_lnp_dir)/AnnouncementWindow"
}

# Download
do_announcement_get() {
    CT_GetGit "announcement" "${CT_ANNOUNCEMENT_VERSION}" \
              "$(get_announcement_url)"	
}

# Extract
do_announcement_extract() {
	# extract in src dir
    CT_Extract "announcement-${CT_ANNOUNCEMENT_VERSION}"
	# patch
	CT_Patch "announcement" "${CT_ANNOUNCEMENT_VERSION}"
}

# Build
do_announcement_build() {
	aw_src_dir="${CT_SRC_DIR}/announcement-${CT_ANNOUNCEMENT_VERSION}"
	dist_dir="$(get_lnp_dir)"
	script="$(get_lnp_dir)/LNP/Utilities/AnnouncementWindow.sh"
	
    # copy to DF dir
	CT_DoExecLog ALL rsync -qa "${aw_src_dir}/" "$(get_lnp_dir)/announcement"
	
	# fix start script
	echo "#!/bin/sh" > ${script}
	echo "cd ../../announcement" >> ${script}
	echo "exec python3 run.py" >> ${script}
	CT_DoExecLog ALL chmod +x "${script}"
	
	# add description
	echo "[AnnouncementWindow.sh:Announcement Window:Announcement filter]" >> ${dist_dir}/LNP/Utilities/utilities.txt
}
