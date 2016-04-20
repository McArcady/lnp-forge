## lnp-forge
Yet another DF LazyNewbPack builder for Linux/MacOS.

### Usage:
`./configure --prefix=$PWD && make install`  
-> configures the tool for your system and install in local directory (`./bin/`)  
`bin/lnp-forge menuconfig`  
-> select DF version and other stuff (optional)  
`bin/lnp-forge build`  
-> download and build components of your LazyNewbPack  

The pack is ready to use in: `.build/src/lnp-x.xx` (and can be moved elsewhere)

### Features:
Components of the pack are downloaded and built from their original repository. No prebuilt binaries from Armok knows where!  
Does include:  
* DwarfFortress
* DFHack + TWBT
* full DFGraphics tilesets
* various keybinds and embark profiles
* Dwarf Therapist
* SoundSense
* Legends Browser

### Dependencies:

lnp-forge checks for the following software:
* git
* mercurial
* gcc-c++
* make & cmake
* python
* java 8
* perl + modules XML::LibXML & XML::LibXSLT
* ncurses
* Qt5
* libraries SDL-image & SDL-ttf

### Bug reports:
Please attach the log file `build.log` to your issue report in Github.
