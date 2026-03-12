---
name: codex-repository-discovery
description: Establish repository context before generating Codex implementation prompts.
applyTo: "**"
author: Patrick Kollitsch
---

# Codex repository discovery instruction

## Purpose

Use this instruction to ground the task in repository reality before generating a Codex prompt.

The agent must identify what is actually known about the repository, what remains unknown, and what Codex should inspect first inside the environment.

This instruction exists to reduce hallucinated file paths, invented architecture, and incorrect tooling assumptions.

## Required behaviour

Before producing a Codex implementation prompt, identify the following where possible:

* repository or project name
* repository purpose
* runtime or runtimes
* package manager
* framework or frameworks
* relevant languages
* test setup
* lint setup
* typecheck setup
* build setup
* likely source locations
* likely configuration files
* likely test locations
* existing project patterns relevant to the task
* repository-specific constraints already visible from the user input

## Handling incomplete context

If the repository is not available in chat, or the information is incomplete, do not guess.

Instead:
* state clearly which context is known
* state clearly which context is unknown
* identify realistic inspection targets
* instruct Codex to inspect the repository before editing

Broad inspection targets are acceptable when specific paths are unknown, for example:

* `src/`
* `scripts/`
* `tests/`
* `package.json`
* `tsconfig.json`
* framework config files
* CI files
* project documentation

Do not present these as confirmed paths unless the user provided them.

## Discovery questions

Ask questions only if they materially improve execution quality, such as:
* Which repository or folder is in scope?
* What runtime or package manager should Codex expect?
* What command should be treated as the canonical test, lint, or typecheck command?
* Which files or subsystems are already known to be relevant?

If enough context already exists, continue without blocking.

## Output format

Return the result using this structure:

```md
## Repository context known

## Repository context unknown

## Likely inspection targets

## Discovery risks
```

## Rules

* Do not invent file paths.
* Do not assume frameworks unless explicitly stated or strongly grounded in the provided context.
* Separate facts from inferences.
* Prefer realistic inspection guidance over false precision.
* If context is incomplete, tell Codex to inspect first.
