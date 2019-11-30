# Install Dwarf-Therapist

get_therapist_description() {
	echo "DwarfTherapist v${CT_THERAPIST_VERSION}"
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
    CT_DoExecLog ALL cmake -DCMAKE_INSTALL_PREFIX=${dist_dir} ..
	CT_DoExecLog ALL make ${JOBSFLAGS} install

	# link to memory layouts
	CT_Pushd "$(get_lnp_dir)/share"
	CT_DoExecLog ALL rm -f "memory_layouts"
	CT_DoExecLog ALL ln -s "dwarftherapist/memory_layouts" .
	CT_Popd
	
	# fix start script
	CT_DoExecLog ALL rm -f "${script}"
	echo "#!/bin/sh" > ${script}
	echo "cd ../../" >> ${script}
	echo "exec bin/dwarftherapist" >> ${script}
	CT_DoExecLog ALL chmod +x "${script}"
	
	# add description
	echo "[DwarfTherapist.sh:Dwarf-Therapist:Management tool that offers several views and interface improvements to Dwarf Fortress]" >> ${dist_dir}/LNP/Utilities/utilities.txt
 	CT_Popd
}
