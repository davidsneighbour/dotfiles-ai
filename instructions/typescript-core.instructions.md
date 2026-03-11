---
name: typescript-core
description: Strict TypeScript development rules for all TypeScript repositories
applyTo: "**/*.ts"
author: Patrick Kollitsch
---

# TypeScript Core Development Rules

## Scope

This instruction file defines strict TypeScript development rules that apply to **all `.ts` files** in repositories that adopt these instructions.

These rules are runtime-agnostic and apply to both Node.js and browser environments.

Repository-specific overlays MAY extend these rules but MUST NOT weaken them.

# Core Principles

Implementations MUST prioritise:

* readability
* explicitness
* maintainability
* correctness

over cleverness, brevity, or implicit behaviour.

Code SHOULD be easy to reason about by a future maintainer without requiring hidden knowledge.

# Language and Module System

* All TypeScript code MUST use **ES Modules (ESM)**.
* Code MUST NOT introduce `require`, `module.exports`, or other CommonJS patterns.
* The assumed JavaScript baseline is **`esnext`**.
* Code MUST prefer native language features over polyfills.

# File Discipline

Files with the `.ts` extension MUST contain valid TypeScript.

They MUST NOT be treated as loosely typed JavaScript.

Repositories MAY contain `.js` files, but `.ts` files MUST remain fully type-checked TypeScript.

# Typing Rules

The following rules are mandatory.

### `any`

* `any` MUST NOT be used, either explicitly or implicitly.
* `unknown` MUST be used when a value's type is not yet known.

### Narrowing

Values typed as `unknown` MUST be narrowed before use using:

* type guards
* schema validation
* runtime checks

### Type Assertions

Type assertions (`as Type`) MUST be avoided unless there is no safer alternative.

When assertions are required, the assumption MUST be clear and justified.

# Nullability Discipline

Code MUST respect strict nullability rules.

Developers MUST assume the presence of:

* `strictNullChecks`
* `exactOptionalPropertyTypes`
* `noUncheckedIndexedAccess`

Optional values MUST be handled intentionally.

Undefined values MUST NOT propagate across module boundaries unintentionally.

# Error Handling

Error handling MUST be explicit.

The following patterns are prohibited:

* empty `catch` blocks
* silent failures
* ignored promise rejections

Example of acceptable catch handling:

```ts
catch (error: unknown) {
  console.error(error)
}
```

Errors MUST be:

* handled
* logged
* or rethrown

but never silently discarded.

# External Input

External input MUST NOT be trusted.

Input MUST be validated before use.

Examples include:

* API responses
* filesystem content
* environment variables
* user input

Validation MAY be implemented through:

* schema validators
* explicit runtime checks
* type guards

# Functions and APIs

Functions MUST follow single-responsibility principles.

Large functions SHOULD be decomposed into smaller helpers.

Public or reusable helpers MUST include **JSDoc documentation**.

Documentation SHOULD include:

* purpose
* parameters
* return values
* examples where helpful

# State and Architecture

Code SHOULD favour:

* pure functions
* immutable data
* composition over inheritance

Large stateful classes SHOULD be avoided unless the architecture clearly benefits from them.

# Imports and Modules

Imports MUST be:

* explicit
* correctly cased
* consistent with repository conventions

Type imports SHOULD be explicit where supported.

Example:

```ts
import type { User } from './types'
```

# Security Practices

Code MUST NOT introduce unsafe behaviour.

Prohibited patterns include:

* dynamic code execution
* unsanitised HTML rendering
* injection-prone queries
* embedded secrets

Secrets MUST NEVER be hardcoded.

# Maintainability

Code SHOULD prioritise clarity.

Avoid:

* deeply nested logic
* large monolithic files
* duplicated type definitions
* implicit behaviour

Comments SHOULD explain **intent**, not restate obvious code behaviour.

Stale comments MUST be removed during refactors.

# Verification Checklist

Before accepting or submitting TypeScript code, verify:

* no `any` exists
* nullability is handled correctly
* errors are not silently swallowed
* external input is validated
* reusable helpers are documented
* module boundaries remain clear
* code prioritises clarity over cleverness
