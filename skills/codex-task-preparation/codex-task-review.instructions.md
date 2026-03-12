---
name: codex-task-review
description: Analyse and refine a rough engineering task before converting it into a Codex execution prompt.
applyTo: "**"
author: Patrick Kollitsch
---

# Codex task review instruction

## Purpose

Use this instruction to analyse a rough engineering task before turning it into a Codex prompt.

The goal is to surface the real objective, separate explicit facts from assumptions, classify the implementation scope, and identify missing details that materially affect execution quality.

This step should happen before prompt generation.

## Review workflow

Perform the following steps in order.

### Step 1: interpret the request

Identify:

#### Goal
What the user is ultimately trying to achieve.

#### Current problem
What issue, limitation, or gap currently exists.

#### Desired outcome
What success looks like once the task is completed.

### Step 2: extract facts

List only explicit information provided by the user.

Examples:
* repository hints
* technologies
* file paths
* commands
* runtime details
* existing behaviour
* constraints
* non-goals

Do not infer anything in this section.

### Step 3: identify assumptions

List inferred information separately.

Examples:
* assumed project structure
* assumed framework conventions
* likely runtime expectations
* likely validation workflow

Mark these clearly as assumptions.

### Step 4: identify implementation scope

Determine what must actually be implemented.

Classify requirements as:

#### MUST
Required for the task to succeed.

#### SHOULD
Strongly desirable but not strictly required.

#### NICE TO HAVE
Optional improvements or secondary enhancements.

### Step 5: identify risks

List risks that could cause implementation failure, wasted effort, or a poor Codex handoff.

Examples:
* ambiguous repository structure
* missing runtime assumptions
* unclear edge-case behaviour
* architectural conflicts
* unclear ownership of files or modules
* missing validation criteria

### Step 6: identify missing information

List only information that materially improves implementation quality.

Ask only necessary questions.

If enough information exists to proceed safely, continue without blocking.

## Output format

Return the result in this structure:

```md
## Goal

## Current problem

## Desired outcome

## Facts provided

## Assumptions inferred

## Implementation scope

### MUST

### SHOULD

### NICE TO HAVE

## Risks

## Missing information

## Clarifying questions
```

## Behaviour rules

* Separate facts from assumptions.
* Do not rewrite the task prematurely.
* Identify risks before proposing solutions.
* Ask only questions that materially improve execution quality.
* Prefer engineering clarity over conversational filler.
