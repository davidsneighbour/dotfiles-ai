---
$schema: ./schema/instructions.json
name: codex-task-to-prompt
description: Convert a rough or reviewed engineering task into an execution-ready prompt for OpenAI Codex.
applyTo: "**"
author: Patrick Kollitsch
---

# Codex task-to-prompt instruction

## Purpose

Use this instruction to convert a rough idea, brainstorm, bug report, refactor goal, or reviewed engineering task into a prompt that OpenAI Codex can execute inside an existing repository or connected environment.

The result must optimise for execution clarity, not discussion.

## Core workflow

Perform the following steps in order.

### Step 1: extract and structure the task

Parse the user's request into the following sections:

#### Task
What the user wants implemented, changed, analysed, fixed, or generated.

#### Known details
Everything the user already provided, including:
* technical constraints
* technologies
* repository or environment hints
* files or folders
* expected behaviour
* workflow constraints
* non-goals

#### Implementation intent
What must actually be implemented, not merely discussed.

#### Unknowns and ambiguities
Anything vague, contradictory, risky, missing, or underspecified.

### Step 2: analyse the task like an engineer

Identify:
* inconsistencies
* hidden assumptions
* edge cases
* missing technical information
* risks that could cause Codex to fail or overreach
* the difference between core requirements and optional extras

Classify requirements as:
* MUST
* SHOULD
* NICE TO HAVE

### Step 3: interrogate the task

Ask only the missing questions that materially improve execution quality.

Group questions by topic when useful and explain briefly why each one matters.

If the task is already sufficiently specified, say so and continue.

### Step 4: rewrite the task into a Codex-optimised brief

Produce a final prompt that is:
* explicit
* implementation-oriented
* repository-aware
* scoped
* test-aware
* careful about assumptions
* suitable for direct use in Codex

## Required Codex prompt structure

The generated Codex prompt must contain the following sections.

### Objective
A short statement of the task.

### Context
Relevant details the user already provided.

If repository specifics are incomplete, instruct Codex to inspect the repository first.

### Constraints
Technical, stylistic, architectural, and workflow constraints.

### Inputs / likely locations
Files, folders, modules, commands, or subsystems Codex should inspect first.

If unknown, say:
`Inspect the repository to identify the correct locations before editing.`

### Required work
A precise ordered list of what Codex should do.

### Deliverables
What Codex must produce, modify, or document.

### Validation
How Codex should verify correctness:
* tests to run
* linting and typecheck commands to run if present
* build commands if relevant
* behavioural checks
* edge cases to confirm

### Assumption policy
Instruct Codex to:
* not invent requirements
* inspect the codebase before changing architecture
* preserve existing conventions
* choose the safest minimal path if critical information is missing
* avoid unrelated refactors

### Expected output format
Instruct Codex to return:
1. what it changed
2. files touched
3. commands run
4. validation results
5. open questions or follow-up items

## Output format

Return the result using this structure:

```md
## Task summary

## Details provided

## What needs implementation

## Gaps / risks

## Questions for clarification

## Codex prompt
```

The `Codex prompt` section must be directly copy-pastable into Codex.

## Behaviour rules

* Optimise for precise execution by Codex.
* Remove vague language.
* Avoid speculative architecture changes.
* Prefer minimal sufficient scope over broad expansion.
* Include validation guidance every time.
