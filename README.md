# wendy-swift-tools

Automated glibc-based Swift Linux SDK bundles for wendyos, targeting Debian 12.

Built from [swift-sdk-generator](https://github.com/swiftlang/swift-sdk-generator). A new SDK is published automatically whenever a new Swift.org stable release is detected.

## Releases

Each [release](https://github.com/wendylabsinc/wendy-swift-tools/releases) corresponds to a Swift.org stable release and contains two artifact bundles:

- `X.Y.Z-RELEASE_wendyos_aarch64.artifactbundle.zip`
- `X.Y.Z-RELEASE_wendyos_x86_64.artifactbundle.zip`

## Usage

Install a bundle with the Swift experimental SDK command:

```bash
swift experimental-sdk install \
  https://github.com/wendylabsinc/wendy-swift-tools/releases/download/X.Y.Z-RELEASE/X.Y.Z-RELEASE_wendyos_aarch64.artifactbundle.zip
```

Replace `X.Y.Z` with the desired Swift version (e.g. `6.3.0`).
