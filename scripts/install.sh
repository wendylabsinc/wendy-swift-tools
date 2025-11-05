#!/bin/bash
set -e

# Variables
SWIFT_PKG_URL="https://download.swift.org/swift-6.2.1-release/xcode/swift-6.2.1-RELEASE/swift-6.2.1-RELEASE-osx.pkg"
WENDY_SDK_URL="https://github.com/wendylabsinc/wendy-swift-tools/releases/download/v0.2-pre-release/6.2.1-RELEASE_wendyos_aarch64.artifactbundle.zip"

SWIFT_PKG_FILE="$(basename $SWIFT_PKG_URL)"
WENDY_SDK_FILE="$(basename $WENDY_SDK_URL)"
WENDY_SDK_NAME="6.2.1-RELEASE_wendyos_aarch64"

# Install Swift Toolchain
echo "Downloading Swift 6.2.1..."
curl -LO "$SWIFT_PKG_URL"

echo "Installing Swift 6.2.1 toolchain... "
sudo installer -pkg "$SWIFT_PKG_FILE" -target /

# Download custom Wendy SDK
echo "Downloading Wendy Swift SDK..."
curl -LO "$WENDY_SDK_URL"

# Remove quarantine attribute
echo "Removing quarantine attribute..."
xattr -d -r com.apple.quarantine "./$WENDY_SDK_FILE"

# Remove existing Wendy SDK if installed
echo "Removing existing Wendy SDK if present..."
xcrun --toolchain swift-6.2.1-RELEASE swift sdk remove "$WENDY_SDK_NAME" || true

# Install the Wendy SDK via swift toolchain
echo "Installing Wendy SDK..."
xcrun --toolchain swift-6.2.1-RELEASE swift sdk install "$WENDY_SDK_FILE"

# Cleanup downloaded files upon successful installation
echo "Cleaning up downloaded files..."
rm -f "$SWIFT_PKG_FILE" "$WENDY_SDK_FILE"

echo "Installation completed successfully!"
