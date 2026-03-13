---
name: Prose compression pass
description: Increase information density and remove repetition
applyTo: "**/*.md"
priority: medium
author: Patrick Kollitsch
---

# Compression pass

This pass shortens the text without losing information.

# Remove repetition

If the same idea appears multiple times:

- keep the clearest explanation
- delete the rest

# Remove paraphrase padding

Delete sentences that restate the thesis without adding detail.

Example:

This highlights how important good architecture really is.

Remove unless the sentence adds evidence.

# Combine sentences

Merge short sentences that express the same idea.

Example:

Bad:

The system stores dependencies in a graph.  
This graph represents module relationships.

Better:

The system stores dependencies in a graph representing module relationships.

# Remove empty paragraphs

Delete paragraphs that contain only emphasis or rhetorical flourish.

Example:

This matters.

This changes everything.

# Target density

Preferred characteristics:

average sentence length: 15–20 words  
high information density  
minimal metaphors
