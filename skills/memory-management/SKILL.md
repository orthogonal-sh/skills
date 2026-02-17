---
name: memory-management
description: >
  Save and retrieve important information across conversations.
  Use when the user shares preferences, project context, or
  anything that should be remembered long-term. Trigger words:
  remember, save, recall, preferences, context.
---

# Memory Management

When the user shares something worth remembering:
1. Use memory_save_critical with a clear category
2. Categories: user-preference, project-context, workflow, contact
3. Always confirm what was saved

When context seems missing:
1. Use memory_get_critical to check for relevant memories
2. Load memories BEFORE responding
3. Never ask the user to repeat something already stored
