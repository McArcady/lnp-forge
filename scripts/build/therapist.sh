# Install Dwarf-Therapist

get_therapist_description() {
	echo "DwarfTherapist ${CT_THERAPIST_VERSION}"
}
get_therapist_credits() {
	echo "Clement Vuchener"
}
get_therapist_url() {
	echo "https://github.com/Dwarf-Therapist/Dwarf-Therapist"
}

# Download
do_therapist_get() {
    # official Dwarf-Therapist from Github
	CT_GetGit "therapist" "${CT_THERAPIST_VERSION}" \
			  "$(get_therapist_url)"
}

# Extract
do_therapist_extract() {
	# extract archived git repo
    CT_Extract "therapist-${CT_THERAPIST_VERSION}"
	# patch
	CT_Patch "therapist" "${CT_THERAPIST_VERSION}"
}

# Build
do_therapist_build() {
	dt_src_dir="${CT_SRC_DIR}/therapist-${CT_THERAPIST_VERSION}"
	dist_dir="$(get_lnp_dir)"
	script="${dist_dir}/LNP/Utilities/DwarfTherapist.sh"

	CT_DoExecLog ALL mkdir -p "${dt_src_dir}/build"
	CT_Pushd "${dt_src_dir}/build"
    CT_DoExecLog ALL cmake -DCMAKE_INSTALL_PREFIX=${dist_dir} -DBUILD_PORTABLE=ON ..
	CT_DoExecLog ALL make ${JOBSFLAGS} install

	# dl experimental layout?
	# e.g: https://raw.githubusercontent.com/cvuchener/Dwarf-Therapist/0.47.01-memory-layouts/share/memory_layouts/linux/v0.47.02_linux64.ini
	if [ "${CT_THERAPIST_EXPERIMENTAL_LAYOUT}" ]; then
		CT_DoGetFile "${CT_THERAPIST_EXPERIMENTAL_LAYOUT}"
		fname=$(basename "${CT_THERAPIST_EXPERIMENTAL_LAYOUT}")
		CT_DoExecLog ALL cp -f "${CT_TARBALLS_DIR}/${fname}" "${get_lnp_dir}/share/memory_layouts/linux/"
	fi
	
	# fix start script
	CT_DoExecLog ALL rm -f "${script}"
	echo "#!/bin/sh" > ${script}
	echo "cd ../../" >> ${script}
	echo "exec bin/dwarftherapist --portable" >> ${script}
	CT_DoExecLog ALL chmod +x "${script}"
	
	# add description
	echo "[DwarfTherapist.sh:Dwarf-Therapist:Management tool that offers several views and interface improvements to Dwarf Fortress]" >> ${dist_dir}/LNP/Utilities/utilities.txt
 	CT_Popd
}
