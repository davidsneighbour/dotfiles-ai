---
name: typescript-architecture
description: Architectural rules and structural patterns for TypeScript repositories
applyTo: "**/*.ts"
author: Patrick Kollitsch
---

# TypeScript Architecture Rules

This file defines architectural design rules for TypeScript repositories.

These rules govern how modules, services, utilities, and domain logic are structured.

They complement:

* typescript-core.instructions.md
* typescript-config-template.instructions.md
* typescript-review.instructions.md

These rules apply regardless of runtime (Node.js, browser, Astro, CLI).

# Architectural Principles

All architecture MUST prioritise:

* clarity
* stability
* maintainability
* predictable boundaries

Architecture MUST avoid:

* implicit coupling
* hidden dependencies
* tightly interwoven modules

Design decisions SHOULD remain understandable to future maintainers.

# Module Boundaries

Modules MUST have clear responsibilities.

A module SHOULD represent:

* a domain concept
* a specific capability
* a defined system boundary

Modules MUST NOT become general-purpose dumping grounds.

# Separation of Concerns

Code SHOULD separate the following concerns whenever possible:

* domain logic
* data access
* external integrations
* user interface
* orchestration

Mixing these layers inside a single module SHOULD be avoided.

Example structure:

```

domain/
services/
integrations/
utils/

```

# Dependency Direction

Dependencies SHOULD point inward toward domain logic.

Higher-level modules MAY depend on lower-level modules.

Lower-level modules MUST NOT depend on higher-level modules.

Example:

```

domain
↑
services
↑
controllers / UI

```

Domain modules SHOULD remain independent from infrastructure details.

# Dependency Injection

External dependencies SHOULD be injected rather than created internally.

Example:

Instead of:

```ts
const client = new DatabaseClient()
```

Prefer:

```ts
function createUserService(client: DatabaseClient) { ... }
```

This improves:

* testability
* modularity
* dependency visibility

# State Management

Shared mutable state SHOULD be avoided.

Prefer:

* immutable data
* explicit state containers
* functional transformations

Global mutable variables MUST NOT be introduced without strong justification.

# Service Design

Services SHOULD follow these rules:

* single responsibility
* explicit lifecycle
* explicit dependencies

Services MAY expose lifecycle methods such as:

```
initialize()
dispose()
```

but SHOULD remain minimal and predictable.

# Utilities

Utility modules SHOULD contain:

* stateless helpers
* reusable pure functions

Utility modules MUST NOT accumulate domain-specific logic.

Domain-specific behaviour belongs in domain modules.

# Domain Modelling

Domain objects SHOULD be represented through explicit types.

Example:

```ts
type OrderStatus =
  | "pending"
  | "processing"
  | "completed"
```

Discriminated unions SHOULD be used for state machines or event systems.

Domain shapes MUST NOT be duplicated across modules.

# External Integrations

External integrations SHOULD be isolated.

Examples:

```
integrations/github
integrations/database
integrations/payment
```

These modules MUST translate external data into internal domain shapes.

Domain code SHOULD NOT depend directly on external APIs.

# Configuration

Configuration MUST be centralised.

Modules SHOULD receive configuration via:

* constructor parameters
* explicit config objects
* shared configuration helpers

Modules MUST NOT read environment variables directly in many locations.

Environment access SHOULD be centralised.

# Error Boundaries

Errors SHOULD be translated at module boundaries.

External errors SHOULD NOT leak directly into domain logic.

Example:

```
APIError → DomainError
```

This keeps internal logic stable even if integrations change.

# File Size and Complexity

Modules SHOULD remain reasonably small.

Warning signs include:

* files exceeding ~300 lines
* deeply nested control flow
* many unrelated responsibilities

When complexity grows, code SHOULD be split into smaller modules.

# Naming Conventions

Names SHOULD reflect domain meaning rather than implementation details.

Prefer:

```
UserService
OrderRepository
PaymentGateway
```

Avoid vague names such as:

```
Manager
Helper
Utils2
```

# Evolution and Refactoring

Architecture SHOULD evolve incrementally.

When introducing new abstractions:

* ensure they solve a real problem
* avoid premature abstraction
* document non-obvious patterns

Refactoring SHOULD simplify code rather than introduce new complexity.

# Verification Checklist

When reviewing architecture, verify:

* module responsibilities are clear
* dependencies flow in the correct direction
* domain logic is independent of integrations
* utilities remain generic
* configuration is centralised
* shared state is controlled
* abstractions are justified
* module boundaries remain stable

Architecture MUST remain understandable without tribal knowledge.
