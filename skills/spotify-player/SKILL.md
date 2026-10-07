---
name: spotify-player
description: Control Spotify playback, devices, queues, playlists, searches, and library actions from an agent workflow.
---

# Spotify Player

Use this skill when a task involves Spotify playback control, queue management, playlist edits, library search, device selection, or music metadata.

## Workflow

- Identify the active account, playback device, target track/album/playlist, and whether the action mutates the library.
- Read current playback and device state before sending commands.
- Confirm before destructive playlist edits or large queue/library changes.
- Verify the resulting playback, queue, playlist, or saved-item state after actions.
