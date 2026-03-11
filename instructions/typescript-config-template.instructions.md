---
name: typescript-config-template
description: Canonical TypeScript configuration baseline for repositories
applyTo: "**/tsconfig*.json"
author: Patrick Kollitsch
---

# TypeScript Configuration Template

This file defines the recommended baseline configuration for TypeScript repositories.

Repositories MAY extend this configuration but SHOULD NOT weaken strictness settings.

# Core Configuration Goals

TypeScript configuration MUST prioritise:

* strict type safety
* predictable module behaviour
* compatibility with modern runtimes
* minimal implicit behaviour

# Canonical Strict Template

The following template SHOULD be used as the starting point for new repositories.

```json
{
  "compilerOptions": {
    "target": "esnext",
    "module": "esnext",
    "moduleResolution": "bundler",

    "strict": true,

    "noImplicitAny": true,
    "strictNullChecks": true,
    "noUncheckedIndexedAccess": true,
    "exactOptionalPropertyTypes": true,

    "noImplicitOverride": true,
    "noImplicitReturns": true,
    "noFallthroughCasesInSwitch": true,

    "useUnknownInCatchVariables": true,

    "isolatedModules": true,
    "verbatimModuleSyntax": true,

    "forceConsistentCasingInFileNames": true,

    "resolveJsonModule": true,

    "skipLibCheck": true,

    "noEmit": true
  }
}
```

# Required Compiler Flags

Repositories adopting these instructions MUST enable:

* `strict`
* `noImplicitAny`
* `strictNullChecks`
* `exactOptionalPropertyTypes`
* `noUncheckedIndexedAccess`
* `useUnknownInCatchVariables`

These settings enforce strong typing discipline.

# Module System

Repositories MUST use:

```
module: esnext
```

and MUST NOT configure CommonJS output.

# Bundler Resolution

Projects using modern bundlers SHOULD use:

```
moduleResolution: bundler
```

This improves compatibility with modern toolchains.

# Optional Settings

Repositories MAY include additional options such as:

* `allowJs`
* `jsx`
* framework plugins
* path aliases

These options are repository-specific and SHOULD be documented locally.

# Standalone Scripts

Some repositories include standalone scripts.

If these scripts require different compilation settings, they MAY use a local `tsconfig`.

However:

* TypeScript quality rules from `typescript-core.instructions.md` still apply.

# Repository Overrides

Repositories MAY override configuration when required by:

* runtime constraints
* frameworks
* build tools

Overrides MUST be documented.

Strictness flags MUST NOT be disabled without justification.
