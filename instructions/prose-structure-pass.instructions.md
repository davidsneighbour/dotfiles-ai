---
name: Prose structure pass
description: Restructure prose to follow logical argument flow
applyTo: "**/*.md"
priority: medium
author: Patrick Kollitsch
---

# Structure pass

This pass reorganises text before stylistic edits.

Focus only on structure.

Do not optimise wording yet.

# Section structure

Each section should follow a clear progression:

Problem  
Mechanism  
Implication

Example:

Problem:
What is broken or confusing.

Mechanism:
How the system works or why the problem exists.

Implication:
Why this matters to the reader.

# Paragraph structure

Each paragraph should follow:

Observation  
Explanation  
Implication

Example:

Observation:
The build system frequently performs full rebuilds.

Explanation:
This happens because the dependency graph contains circular imports.

Implication:
Incremental compilation becomes unreliable.

# Remove structural filler

Delete sections that exist only to transition between topics.

Examples:

- "Before we dive deeper"
- "At a high level"
- "In this section we explore"

Replace with direct progression.

# Avoid listicle structure

Avoid paragraphs starting with:

The first reason  
The second reason  
The third takeaway

Convert them into natural paragraphs or real lists.

# Ensure argument progression

Each section must introduce new information.

If two sections make the same point, merge them.
