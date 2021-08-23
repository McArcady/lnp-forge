# Build Snap package

get_snap_description() {
	echo "Snap package generated with FPM"
}
get_snap_credits() {
	echo $(get_fpm_credits)
}
get_snap_url() {
	echo $(get_fpm_url)
}
get_snap_license() {
	echo -n
}
get_snap_dir() {
	echo -n
}
do_snap_get() {
	echo -n
}
do_snap_extract() {
	echo -n
}

do_snap_build() {
	yname="snapcraft.yaml"
	name="linux-dwarf-pack"
	dist_dir="/opt/${name}"
	deps=$(get_debian_dependencies | sed 's/ /, /g')
	build_deps=$(get_debian_build_dependencies | sed 's/ /, /g')
	tr -d '\t' > ${yname} << EOF
	name: ${name}
	base: core18
	version: ${CT_VERSION}
	summary: Dwarf Fortress
	description: A simple ready-to-play Dwarf Fortress starter pack
	grade: stable
	confinement: devmode
	apps:
	  linux-dwarf-pack:
	    command: ${dist_dir}/linux-dwarf-pack.sh
	parts:
	  linux-dwarf-pack:
	    build-packages: [${build_deps}]
	    stage-packages: [${deps}]
	    plugin: autotools
		source: .
		override-build: |
		  autoconf && ./configure --prefix=. && make install
		  echo "CT_LOG_PROGRESS_BAR=n" >> .config
		  ./bin/lnp-forge build
		  mkdir -p /opt/linux-dwarf-pack
		  rsync -qa .build/src/lnp-0.14a/* /opt/linux-dwarf-pack
	architectures:
	  - build-on: amd64
	contact: http://www.bay12forums.com/smf/index.php?topic=157712
	website: http://www.bay12forums.com/smf/index.php?topic=157712
#	donate: https://www.paypal.com/donate/?business=mcarcady%40gmail.com&item_name=Create+and+expand+the+LinuxDwarfPack%21&currency_code=EUR
#	icon: /usr/share/icons/hicolor/256x256/apps/linux-dwarf-pack.png
	license: Proprietary
EOF
	
	# do_fpm_build "snap" \
	# 			 "libsdl-image1.2 libsdl-ttf2.0-0 libopenal1 libsndfile1 gnome-terminal openjdk-11-jre python3-tk python3-distutils python3-pil.imagetk libqt5qml5 libqt5concurrent5 libqt5gui5 unionfs-fuse libcanberra-gtk-module" \
	# 			 "--architecture amd64 --snap-yaml ${yname}"
	#CT_DoExecLog ALL rm ${yname}
}
