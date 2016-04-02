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
Includes:  
* DwarfFortress
* DFHack + TWBT
* full DFGraphics tilesets
* various keybinds and embark profiles
* Dwarf Therapist
* SoundSense
* Legends Browser
