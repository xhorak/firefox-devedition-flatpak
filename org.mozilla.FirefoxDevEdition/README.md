# Firefox DevEdition flatpak package

## Required packages to build
This is required to install `cargo-vendor` for downloading cbindgen crate
which is required by the Firefox build.
- openssh-devel
- cmake
- cargo
- rust

## Building
Use the `build.sh` script from parent directory:
```
./build.sh org.mozilla.FirefoxDevEdition
```
# Installation
Use install.sh script from parent directory:
```
./install.sh org.mozilla.FirefoxDevEdition
```
# Running
```
flatpak run org.mozilla.FirefoxDevEdition
```
