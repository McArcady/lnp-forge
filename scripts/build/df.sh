# Install DwarfFortress

get_df_description() {
	echo "DwarfFortress v${CT_DF_VERSION}"
}
get_df_credits() {
	echo "Tarn and Zach Adams"
}
get_df_url() {
	echo "http://www.bay12games.com/dwarves/"
}
get_df_license() {
	year=$(date +%Y)
	echo "Copyright (c) 2002-${year} - All rights are retained by Tarn Adams"
}

get_df_dir() {
	echo "$(get_lnp_dir)/df_${CT_DF_VERSION}"
}

# Download DF
do_df_get() {
    # official DF.
	# e.g http://www.bay12games.com/dwarves/df_42_06_linux.tar.bz2
    CT_GetFile "df_${CT_DF_VERSION}" ".tar.bz2" \
               http://www.bay12games.com/dwarves/
}

# Extract DF
do_df_extract() {
	# extract in src dir
    df_file="${CT_TARBALLS_DIR}/df_${CT_DF_VERSION}.tar.bz2"
	df_dir="${CT_SRC_DIR}/df_${CT_DF_VERSION}"

	# create base dir missing from archive (since v0.50 ?)
	CT_DoExecLog ALL mkdir -p "$df_dir"
	CT_DoExecLog ALL tar xjf ${df_file} -C "$df_dir"

	# rename start script for compatibility with PyLNP
	CT_DoExecLog ALL mv "$df_dir/run_df" "$df_dir/df"
}

do_df_build() {
    # copy to DF dir
	CT_DoExecLog ALL rsync -qa "${CT_SRC_DIR}/df_${CT_DF_VERSION}" "$(get_lnp_dir)"
}
