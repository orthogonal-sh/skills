---
name: swiftui-empty-app-init
description: Scaffold a minimal SwiftUI iOS app with XcodeGen and a clean starting project structure.
---

# SwiftUI Empty App Init

Use this skill when starting a new minimal SwiftUI app from an empty directory.

## When To Use

- Create a tiny iOS app skeleton without an existing Xcode project.
- Generate `project.yml` for XcodeGen.
- Add a simple SwiftUI app entry point and first view.
- Keep scaffolding small enough for later customization.

## Starter Flow

```bash
xcodegen generate
open *.xcodeproj
```

## Files To Create

- `project.yml`
- `Sources/App.swift`
- `Sources/ContentView.swift`

## Notes

Use native SwiftUI conventions and keep package or workspace complexity out unless the user asks for it.
