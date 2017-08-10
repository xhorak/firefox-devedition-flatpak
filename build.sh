#!/bin/sh
set -e
#rm -rf app repo
rm -rf app
if [ -z $1 ]; then
  echo "Usage: $0 APP"
  echo ""
  echo "Example"
  echo "  $0 org.mozilla.FirefoxDevEdition"
  exit 1
else
  APP_NAME=$1
fi

# Prepare Nightly Upstream (with correct URL & checksum)
if [[ $APP_NAME == 'org.mozilla.FirefoxNightlyUpstreamBinary' ]]
then
  # Not sure how to automate the version string yet
  # (needs changing every 6 weeks or so)
  VERSION=57.0

  FILE=${APP_NAME}/${APP_NAME}.json
  URL=https://download-installer.cdn.mozilla.net/pub/firefox/nightly/latest-mozilla-central/firefox-${VERSION}a1.en-US.linux-x86_64.checksums
  TARBALL=https://download-installer.cdn.mozilla.net/pub/firefox/nightly/latest-mozilla-central/firefox-${VERSION}a1.en-US.linux-x86_64.tar.bz2
  CHECKSUM=$(curl ${URL} | grep sha256 | grep bz2$ | cut -f1 -d' ')

  sed -i "s|url\".*|url\"\: \"$TARBALL\"\,|" "$FILE"
  sed -i "s|sha256\".*|sha256\"\: \"$CHECKSUM\"\,|" "$FILE"
fi

# Build repo
flatpak-builder $GPG_SETTINGS --verbose --force-clean --ccache --require-changes --repo=repo --subject="Build of $APP_NAME" app $APP_NAME/$APP_NAME.json

# Get rid of old files in repo
flatpak build-update-repo $GPG_SETTINGS --prune --prune-depth=2 repo

# Build .flatpak file
flatpak build-bundle $GPG_BUNDLE_SETTINGS repo $APP_NAME.flatpak $APP_NAME

# Clean up Nightly Upstream (if applicable)
if [[ $APP_NAME == 'org.mozilla.FirefoxNightlyUpstreamBinary' ]]
then
  git checkout HEAD "$FILE"
fi
