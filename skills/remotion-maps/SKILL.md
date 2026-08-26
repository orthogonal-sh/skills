---
name: remotion-maps
description: Build Remotion map scenes with tiles, routes, markers, camera motion, and render-safe assets
---

# Remotion Maps

Use this skill when creating or debugging map-based videos in Remotion.

## Workflow

1. Define the map provider, tile source, attribution, route data, markers, and output dimensions.
2. Preload or cache map assets so renders are deterministic.
3. Animate camera moves with stable coordinates, zoom levels, and easing.
4. Keep labels, markers, and route strokes legible at final export size.
5. Render a short preview and inspect frames for missing tiles or layout drift.

## Checks

- Confirm provider licensing and attribution.
- Avoid live network dependency during final render when possible.
- Test high-DPI and social aspect ratios.
- Keep route geometry simplified enough for smooth playback.
