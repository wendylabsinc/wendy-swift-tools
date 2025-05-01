#!/bin/bash
set -e

# Variables
SWIFT_PKG_URL="https://download.swift.org/swift-6.1-release/xcode/swift-6.1-RELEASE/swift-6.1-RELEASE-osx.pkg"
EDGE_SDK_URL="https://github.com/apache-edge/edge-swift-sdk/releases/download/v0.1-pre-release/6.1-RELEASE_edgeos_aarch64.artifactbundle.tar.gz"

SWIFT_PKG_FILE="$(basename \"$SWIFT_PKG_URL\")"
EDGE_SDK_FILE="$(basename \"$EDGE_SDK_URL\")"
EDGE_SDK_NAME="6.1-RELEASE_edgeos_aarch64"

# Install Swift Toolchain
echo "Downloading Swift 6.1..."
curl -LO "$SWIFT_PKG_URL"

echo "Installing Swift 6.1 toolchain..."
sudo installer -pkg "$SWIFT_PKG_FILE" -target /

# Download custom Edge SDK
echo "Downloading Edge Swift SDK..."
curl -LO "$EDGE_SDK_URL"

# Remove quarantine attribute
echo "Removing quarantine attribute..."
xattr -d -r com.apple.quarantine "./$EDGE_SDK_FILE"

# Remove existing Edge SDK if installed
echo "Removing existing Edge SDK if present..."
xcrun --toolchain swift-6.1-RELEASE swift sdk remove "$EDGE_SDK_NAME" || true

# Install the Edge SDK via swift toolchain
echo "Installing Edge SDK..."
xcrun --toolchain swift-6.1-RELEASE swift sdk install "$EDGE_SDK_FILE"

# Cleanup downloaded files upon successful installation
echo "Cleaning up downloaded files..."
rm -f "$SWIFT_PKG_FILE" "$EDGE_SDK_FILE"

echo "Installation completed successfully!"

