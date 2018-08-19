#!/bin/sh
set -ux

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install flathub org.gnome.Platform//3.28 org.gnome.Sdk//3.28
flatpak install flathub org.freedesktop.Sdk.Extension.rust-stable//1.6
