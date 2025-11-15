
# Wendy Swift Tools
[![macOS](https://img.shields.io/badge/macOS-15%2B-blue?logo=apple)](https://developer.apple.com/macos/)
[![Linux](https://img.shields.io/badge/Linux-Ubuntu%2024.04-green?logo=linux)](https://ubuntu.com/)

Wendy needs custom Swift SDKs. This repository hosts prebuilt bundles and helper installers so you can get up and running quickly on Apple silicon and popular Linux targets. Windows support is coming soon—keep an eye on our releases for the first preview build.

## Installation

### Quick Install (Latest Release)

Run the install script to automatically download and install the latest Swift toolchain and Wendy SDK:

```bash
curl -sSL https://raw.githubusercontent.com/wendylabsinc/wendy-swift-tools/main/scripts/install.sh | bash
```

Or clone the repository and run locally:

```bash
git clone https://github.com/wendylabsinc/wendy-swift-tools.git
cd wendy-swift-tools
./scripts/install.sh
```

### Install Specific Version

You can specify a release tag to install a specific version:

```bash
# Install 0.3.0 (Swift 6.2.1) - default
./scripts/install.sh 0.3.0

# Install v0.2-pre-release (Swift 6.2)
./scripts/install.sh v0.2-pre-release

# Install v0.1-pre-release (Swift 6.1)
./scripts/install.sh v0.1-pre-release
```

### Available Releases

| Release Tag | Swift Version | SDK Architecture |
|------------|---------------|------------------|
| 0.3.0 | 6.2.1 | wendyos_aarch64 |
| v0.2-pre-release | 6.2 | wendyos_aarch64 |
| v0.1-pre-release | 6.1 | wendyos_aarch64 |

### What Gets Installed

The install script will:
1. Download and install the official Swift toolchain for macOS
2. Download the Wendy custom SDK for the corresponding Swift version
3. Register the SDK with the Swift toolchain
4. Clean up downloaded files after successful installation

### Requirements

- macOS with admin privileges (for Swift toolchain installation)
- curl for downloading files
- Active internet connection

### Usage

After installation, you can use the Wendy SDK with Swift:

```bash
# List installed SDKs
xcrun --toolchain swift-6.2.1-RELEASE swift sdk list

# Build for Wendy OS
xcrun --toolchain swift-6.2.1-RELEASE swift build --sdk 6.2.1-RELEASE_wendyos_aarch64
```

## Contributing

Issues, fixes, and feature requests are welcome. Please open a pull request or start a discussion so we can keep improving Wendy together.
