#!/bin/bash
set -e

# Default tag (latest release)
DEFAULT_TAG="v0.2-pre-release"
TAG="${1:-$DEFAULT_TAG}"

# Show usage
if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    echo "Usage: $0 [TAG]"
    echo "  TAG: GitHub release tag to use (default: $DEFAULT_TAG)"
    echo "  Example: $0 v0.1-pre-release"
    exit 0
fi

echo "Using release tag: $TAG"

# Fetch release info from GitHub
RELEASE_INFO=$(curl -s "https://api.github.com/repos/edgeengineer/edge-swift-tools/releases/tags/$TAG")

if [ "$(echo "$RELEASE_INFO" | grep -c '"message": "Not Found"')" -eq 1 ]; then
    echo "Error: Release tag '$TAG' not found"
    echo "Available tags:"
    curl -s "https://api.github.com/repos/edgeengineer/edge-swift-tools/releases" | grep -o '"tag_name": "[^"]*"' | cut -d'"' -f4
    exit 1
fi

# Extract SDK filename and Swift version from release assets
EDGE_SDK_FILE=$(echo "$RELEASE_INFO" | grep -o '"name": "[^"]*\.artifactbundle\.[^"]*"' | head -1 | cut -d'"' -f4)

if [ -z "$EDGE_SDK_FILE" ]; then
    echo "Error: No SDK artifact found in release $TAG"
    exit 1
fi

# Extract Swift version from SDK filename (e.g., 6.1 or 6.2)
SWIFT_VERSION=$(echo "$EDGE_SDK_FILE" | grep -o '^[0-9]\.[0-9]')
EDGE_SDK_NAME="${SWIFT_VERSION}-RELEASE_edgeos_aarch64"

# Variables
SWIFT_PKG_URL="https://download.swift.org/swift-${SWIFT_VERSION}-release/xcode/swift-${SWIFT_VERSION}-RELEASE/swift-${SWIFT_VERSION}-RELEASE-osx.pkg"
EDGE_SDK_URL="https://github.com/edgeengineer/edge-swift-tools/releases/download/$TAG/$EDGE_SDK_FILE"

SWIFT_PKG_FILE="$(basename $SWIFT_PKG_URL)"

# Install Swift Toolchain
echo "Downloading Swift $SWIFT_VERSION..."
curl -LO "$SWIFT_PKG_URL"

echo "Installing Swift $SWIFT_VERSION toolchain... "
sudo installer -pkg "$SWIFT_PKG_FILE" -target /

# Download custom Edge SDK
echo "Downloading Edge Swift SDK ($EDGE_SDK_FILE)..."
curl -LO "$EDGE_SDK_URL"

# Remove quarantine attribute
echo "Removing quarantine attribute..."
xattr -d -r com.apple.quarantine "./$EDGE_SDK_FILE"

# Extract if it's a zip file
if [[ "$EDGE_SDK_FILE" == *.zip ]]; then
    echo "Extracting SDK from zip..."
    unzip -q "$EDGE_SDK_FILE"
    # Update to the extracted file name
    EDGE_SDK_FILE="${EDGE_SDK_FILE%.zip}"
fi

# Remove existing Edge SDK if installed
echo "Removing existing Edge SDK if present..."
xcrun --toolchain swift-${SWIFT_VERSION}-RELEASE swift sdk remove "$EDGE_SDK_NAME" || true

# Install the Edge SDK via swift toolchain
echo "Installing Edge SDK..."
xcrun --toolchain swift-${SWIFT_VERSION}-RELEASE swift sdk install "$EDGE_SDK_FILE"

# Cleanup downloaded files upon successful installation
echo "Cleaning up downloaded files..."
rm -rf "$SWIFT_PKG_FILE" "$EDGE_SDK_FILE" "${EDGE_SDK_FILE%.tar.gz}" "${EDGE_SDK_FILE%.zip}"

echo "Installation completed successfully!"
echo "Swift version: $SWIFT_VERSION"
echo "Edge SDK: $EDGE_SDK_NAME"

