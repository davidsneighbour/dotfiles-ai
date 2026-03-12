---
$schema: ./schema/instructions.json
name: codex-implementation-plan
description: Generate a Codex Ask-mode planning prompt and a Codex Code-mode execution prompt for a reviewed task.
applyTo: "**"
author: Patrick Kollitsch
---

# Codex implementation plan instruction

## Purpose

Use this instruction after the task has been reviewed and shaped.

It produces two Codex handoff prompts:

1. a Codex Ask-mode prompt
2. a Codex Code-mode prompt

The Ask-mode prompt is used to inspect the repository, understand the architecture, and propose an implementation plan before any code is changed.

The Code-mode prompt is used to execute the implementation.

## Workflow

### Step 1: understand the objective

Identify:

* what must be implemented
* expected behaviour
* scope boundaries
* known repository context
* missing repository context that Codex must inspect first

### Step 2: produce the Ask-mode prompt

The Ask-mode prompt must instruct Codex to:

* inspect the repository
* identify relevant files and folders
* identify project conventions
* identify architecture patterns relevant to the task
* identify risks, blockers, or unclear assumptions
* propose implementation steps
* propose a validation approach

The Ask-mode prompt must not instruct Codex to edit code yet.

### Step 3: produce the Code-mode prompt

The Code-mode prompt must instruct Codex to implement the task using the repository context and plan.

It must include the following sections:

#### Objective

A short statement of the task.

#### Context

Relevant user and repository context.

#### Constraints

Rules that must be followed during implementation.

#### Likely locations

Files or folders to inspect first.

If uncertain, instruct Codex to inspect the repository before editing.

#### Required work

An ordered list of implementation tasks.

#### Deliverables

Files, tests, docs, or configuration changes that should result.

#### Validation

Commands or checks Codex should run to verify success.

If the canonical commands are unknown, instruct Codex to inspect the repository and use the project's existing validation workflow.

### Step 4: define assumption policy

Both prompts must reinforce these rules:

* inspect the repository before making architecture changes
* preserve existing conventions
* avoid unrelated refactors
* make minimal safe assumptions
* state assumptions explicitly where they matter

## Output format

Return the result using this structure:

```md
## Task summary

## Codex Ask-mode prompt

## Codex Code-mode prompt
```

Both prompts must be directly copy-pastable into Codex.

## Behaviour rules

* Plan before implementation.
* Prioritise repository awareness.
* Prefer minimal safe implementation over speculative expansion.
* Always include validation steps.
* Preserve existing project conventions.
