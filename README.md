## lnp-forge
Yet another DF LazyNewbPack builder for Linux/MacOS.

### Usage:
`./configure --prefix=$PWD && make install`  
-> configures the tool for your system and install in local directory (`./bin/`)  
`./bin/lnp-forge menuconfig`  
-> change DF version and other stuff (optional)  
`./bin/lnp-forge build`  
-> downloads and builds components of your LazyNewbPack  

The pack is ready to use in: `.build/src/lnp-x.xx` (and can be moved elsewhere)

Optionally, you can also build an rpm package for Fedora by running:
```bash
fedpkg --release f32 local # Replace f32 for the version of fedora for which you want to build the pack
```

After building it, the binary rpm package can be found in `x86_64/linux-dwarf-pack-*.*.x86_64.rpm`.

### Features:
Components of the pack are downloaded and built from their original repository. No prebuilt binaries from Armok knows where!  
Does include:  
* Dwarf Fortress
* DFHack + TWBT
* full DFGraphics tilesets
* various keybinds and embark profiles
* Dwarf Therapist
* SoundSense
* Legends Browser
* Announcement Window

### Dependencies:
lnp-forge checks for the following software:
* git
* gcc-c++
* make & cmake
* Tcl/Tk
* python3 + module Tkinter
* java 8
* perl + modules XML::LibXML & XML::LibXSLT
* ncurses
* Qt5
* libraries OpenAL, SDL-image & SDL-ttf
  
Check the wiki (<https://github.com/McArcady/lnp-forge/wiki/Installing-build-dependencies>) for help on installing those dependencies.

### Bug reports:
Please attach the log file `build.log` to your issue report in Github.  
For help and discussion, see also the [Bay12 forums lnp-forge topic](http://www.bay12forums.com/smf/index.php?topic=157712).
