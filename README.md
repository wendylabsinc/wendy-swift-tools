# Edge Swift tools
Edge needs custom swift SDKs. This repo will host those releases as well as install scripts.

## Installation

### Quick Install (Latest Release)

Run the install script to automatically download and install the latest Swift toolchain and Edge SDK:

```bash
curl -sSL https://raw.githubusercontent.com/edgeengineer/edge-swift-tools/main/scripts/install.sh | bash
```

Or clone the repository and run locally:

```bash
git clone https://github.com/edgeengineer/edge-swift-tools.git
cd edge-swift-tools
./scripts/install.sh
```

### Install Specific Version

You can specify a release tag to install a specific version:

```bash
# Install v0.1-pre-release (Swift 6.1)
./scripts/install.sh v0.1-pre-release

# Install v0.2-pre-release (Swift 6.2) - default
./scripts/install.sh v0.2-pre-release
```

### Available Releases

| Release Tag | Swift Version | SDK Architecture |
|------------|---------------|------------------|
| v0.2-pre-release | 6.2 | edgeos_aarch64 |
| v0.1-pre-release | 6.1 | edgeos_aarch64 |

### What Gets Installed

The install script will:
1. Download and install the official Swift toolchain for macOS
2. Download the Edge custom SDK for the corresponding Swift version
3. Register the SDK with the Swift toolchain
4. Clean up downloaded files after successful installation

### Requirements

- macOS with admin privileges (for Swift toolchain installation)
- curl for downloading files
- Active internet connection

### Usage

After installation, you can use the Edge SDK with Swift:

```bash
# List installed SDKs
xcrun --toolchain swift-6.2-RELEASE swift sdk list

# Build for Edge OS
xcrun --toolchain swift-6.2-RELEASE swift build --sdk 6.2-RELEASE_edgeos_aarch64
```
