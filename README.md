## lnp-forge
Builder script for the LinuxDwarfPack.

### Usage:
`./configure --prefix=$PWD && make install`  
-> configures the tool for your system and install in a local directory (`./bin/`)  
`./bin/lnp-forge menuconfig`  
-> change DF version and other stuff (optional), select types of package to build  
`./bin/lnp-forge build`  
-> downloads and builds components of your pack  

The pack is ready to use in: `.build/src/lnp-x.xx` (and can be renamed/moved elsewhere)

### Features:
Components of the pack are downloaded and built from their original repository. No prebuilt binaries from Armok knows where!  
Does include:  
* Dwarf Fortress
* DFHack + TWBT
* full DFGraphics tilesets
* various keybinds and embark profiles
* Dwarf Therapist
* SoundSense-RS
* Legends Browser 1 & 2
* Announcement Window

### Dependencies:
lnp-forge checks for the following software:
* git
* gcc-c++
* make & cmake
* Tcl/Tk
* python3 + module Tkinter
* java 8 or 11
* perl + modules XML::LibXML & XML::LibXSLT
* ncurses, rsync, help2man
* Qt5
* libraries OpenAL, SDL-image & SDL-ttf
  
Check the wiki (<https://github.com/McArcady/lnp-forge/wiki/Installing-build-dependencies>) for help on installing those dependencies.

### Bug reports:
Please attach the log file `build.log` to your issue report in Github.  
For help and discussion, see also the [Bay12 forums lnp-forge topic](http://www.bay12forums.com/smf/index.php?topic=157712).
