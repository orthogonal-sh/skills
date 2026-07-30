---
name: macos-spm-app-packaging
description: Scaffold, build, sign, and package SwiftPM-based macOS apps without an Xcode project.
---

# macOS SPM App Packaging

Use this skill when creating or packaging a macOS app from Swift Package Manager sources.

## Workflow

1. Inspect the package structure, targets, resources, bundle identifier, and minimum macOS version.
2. Build the app bundle with stable paths for executable, resources, icons, and Info.plist.
3. Apply signing, notarization, or distribution steps only when credentials and intent are clear.
4. Verify the bundle launches and document the output artifact path.
