---
name: codex-task-preparation
description: Prepare a rough engineering task for OpenAI Codex by discovering repository context, reviewing the task, shaping a Codex-ready prompt, and producing Ask-mode and Code-mode handoff prompts.
---

# Codex task preparation

## Purpose

This skill converts a rough idea, feature request, bug report, refactor goal, or workflow description into a repository-aware Codex handoff.

Use this skill when the user wants to:
* prepare a task for Codex
* turn brainstorming into an implementation brief
* identify missing details before handing work to Codex
* generate Ask-mode and Code-mode prompts for a repository task

This skill orchestrates the following local instruction files:

1. `codex-repository-discovery.instructions.md`
2. `codex-task-review.instructions.md`
3. `codex-task-to-prompt.instructions.md`
4. `codex-implementation-plan.instructions.md`

## Workflow

Execute the following phases in order.

### Phase 0: repository discovery

Apply `codex-repository-discovery.instructions.md`.

Goal:
* establish known repository context
* identify unknown context that Codex must inspect
* identify likely starting points for inspection
* reduce invented assumptions

### Phase 1: task review

Apply `codex-task-review.instructions.md`.

Goal:
* identify the real objective
* separate facts from assumptions
* classify scope and requirements
* identify risks and blockers
* identify the minimum missing information that matters

### Phase 2: task-to-prompt shaping

Apply `codex-task-to-prompt.instructions.md`.

Goal:
* turn the reviewed task into a Codex-oriented implementation brief
* define objective, context, constraints, work, deliverables, validation, and assumption policy
* produce a copy-pastable prompt

### Phase 3: implementation planning

Apply `codex-implementation-plan.instructions.md`.

Goal:
* produce a Codex Ask-mode prompt for repository inspection and planning
* produce a Codex Code-mode prompt for implementation
* preserve project conventions and limit scope creep

## Final output

Return the result in this structure:

```md
## Task summary

## Repository discovery

## Review results

## Clarifying questions

## Codex Ask-mode prompt

## Codex Code-mode prompt
```

All generated prompts must be directly copy-pastable into Codex.

## Behaviour rules

* Prioritise repository awareness over speed.
* Do not invent file paths, frameworks, commands, or architecture.
* Ask only questions that materially improve implementation quality.
* Prefer a safe narrow scope over speculative expansion.
* Always include validation guidance.
* Preserve existing project conventions and avoid unrelated refactors.
