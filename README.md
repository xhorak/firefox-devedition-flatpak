# firefox-flatpak
This is a set of patches, scripts and a manifest to build latest Firefox using Flatpak. DevEdition and Nightly are using GNOME 3.34 as base runtime. The UpstreamBinary Flatpak uses the FreeDesktop Platform for GNOME and KDE.

# Usage

Run ```./setup_runtime.sh``` to download and install GNOME SDK and FreeDesktop Platform for Flatpak.

Currently there are three builds available:
* org.mozilla.FirefoxNightly - to build latest nightly
* org.mozilla.FirefoxNightlyWayland - to build nightly with wayland support
* org.mozilla.FirefoxDevEdition - Firefox Developer Edition (branded aurora build)

## Prerequisites

Of course to build flatpaks the ```flatpak-builder``` package needs to be installed.

Please see the accompanying README.md in the specific build directory for further build requirements, e.g.
* org.mozilla.FirefoxNightly/README.md

## Build

To build specific build run:
```
./build.sh BUILD_NAME
```
for example 
```
./build.sh org.mozilla.FirefoxNightly
``` 
will build Firefox from master branch.

After the build is finished you can install the app by:
```
./install.sh BUILD_NAME
```

To start Firefox use:
```
flatpak run BUILD_NAME
```

For example:
```
flatpak run org.mozilla.FirefoxNightly
```

# Repository

Created repository with some additional instructions can be found there: https://firefox-flatpak.mojefedora.cz/
