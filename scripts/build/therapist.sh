# Install Dwarf-Therapist

# Download
do_therapist_get() {
    # official Dwarf-Therapist from Github
	CT_GetGit "therapist" "${CT_THERAPIST_VERSION}" \
			  https://github.com/splintermind/Dwarf-Therapist.git
}

# Extract
do_therapist_extract() {
	# extract archived git repo
    CT_Extract "therapist-${CT_THERAPIST_VERSION}"
}

# Build
do_therapist_build() {
	dt_src_dir="${CT_SRC_DIR}/therapist-${CT_THERAPIST_VERSION}"
	dist_dir="$(get_lnp_dir)"

	CT_Pushd "${dt_src_dir}"
    CT_DoExecLog ALL qmake-qt5 PREFIX=${dist_dir}
	CT_DoExecLog ALL make ${JOBSFLAGS} install
	# link with .sh extension required for detection by LNP
	CT_DoExecLog ALL rm -f "${dist_dir}/LNP/Utilities/DwarfTherapist.sh"
	CT_DoExecLog ALL ln -s "${dist_dir}/bin/DwarfTherapist" "${dist_dir}/LNP/Utilities/DwarfTherapist.sh"
	
	# add description
	echo "[DwarfTherapist.sh:Dwarf-Therapist:Management tool that offers several views and interface improvements to Dwarf Fortress]" >> ${dist_dir}/LNP/Utilities/utilities.txt
 	CT_Popd
}
