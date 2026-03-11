---
name: astro-typescript
description: Astro-specific TypeScript rules and patterns
applyTo: "**/*.ts, **/*.astro"
author: Patrick Kollitsch
---

# Astro TypeScript Rules

These instructions extend the generic TypeScript rules with Astro-specific practices.

They apply to repositories built with **Astro 5+**.

# Astro Integration Principles

TypeScript SHOULD integrate with Astro using:

* Astro content collections
* framework-provided types
* explicit imports

Avoid ad-hoc typing where official Astro types exist.

# Content Collections

When working with Astro content collections:

* Prefer `CollectionEntry` types from `astro:content`
* Avoid manually reconstructing collection shapes
* Narrow collection data before use

Example:

```ts
import type { CollectionEntry } from 'astro:content'
```

# Frontmatter and Data

Frontmatter values MUST NOT be assumed to be correctly typed.

Values SHOULD be validated or narrowed before use.

Avoid:

```
Record<string, unknown>
```

unless the structure is truly dynamic.

# Astro Components

Astro component props SHOULD be typed explicitly.

Example:

```ts
interface Props {
  title: string
}
```

Props SHOULD be validated or narrowed if they originate from frontmatter.

# Image Handling

When using Astro image tooling:

Types such as `ImageMetadata` MUST be imported explicitly.

Avoid relying on implicit types.

# Client and Server Separation

Astro projects frequently mix server and browser logic.

Code SHOULD clearly separate:

* server-side logic
* client-side behaviour

Browser APIs MUST NOT appear in server-only contexts.

# Page Transitions

Projects using Astro client navigation MUST ensure event listeners are reattached after navigation.

Example lifecycle event:

```
astro:page-load
```

Scripts SHOULD re-register DOM listeners accordingly.

# Deprecated Patterns

Avoid outdated Astro patterns.

Code SHOULD use modern Astro 5+ idioms and APIs.

# Imports

Astro projects often define path aliases.

Aliases SHOULD be preferred over long relative paths.

Example:

```
@utils/...
```

# Maintainability

Business logic SHOULD NOT be embedded deeply inside `.astro` templates.

Complex behaviour SHOULD live in typed helper modules.
