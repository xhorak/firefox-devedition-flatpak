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
  # Delete trailing slash from directory command line completion, if present.
  APP_NAME=${1%/}
fi

# Append Cargo bin directory to PATH, considering CARGO_HOME if set.
PATH="$PATH:${CARGO_HOME:-$HOME/.cargo}/bin"

if [ -f $APP_NAME/prepare_sources ]; then
  cd $APP_NAME
  if ./prepare_sources; then
    echo "Sources prepared"
  else
    echo "Preparing sources failed: sources are required to start build of the package..."
    echo "Check above output for failure."
    #exit 1
  fi
  cd -
fi

# Build repo
flatpak-builder $GPG_SETTINGS --verbose --force-clean --ccache --require-changes --repo=repo --subject="Build of $APP_NAME" app $APP_NAME/$APP_NAME.json

# Get rid of old files in repo
flatpak build-update-repo $GPG_SETTINGS --prune --prune-depth=1 repo

# Build .flatpak file
flatpak build-bundle $GPG_BUNDLE_SETTINGS repo $APP_NAME.flatpak $APP_NAME
