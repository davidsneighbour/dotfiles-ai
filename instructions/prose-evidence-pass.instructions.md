---
name: Prose evidence pass
description: Strengthen prose by grounding claims in mechanism, example, source, or measurable result
applyTo: "**/*.md"
priority: medium
author: Patrick Kollitsch
---

# Evidence pass

This pass checks whether claims are supported.

Focus on proof, mechanism, and specificity.

Do not primarily optimise style in this pass.

## Goal

Every non-trivial claim should be supported by at least one of the following:

- mechanism
- example
- metric
- named source
- direct observation

If a claim cannot be supported, weaken or remove it.

## Required checks

### Mechanism check

Do not write claims that only assert an outcome.

Bad:

This improves maintainability.

Better:

This improves maintainability because the module boundary is now explicit and the dependency graph is smaller.

### Example check

Abstract claims should usually have a concrete example.

Bad:

This pattern causes deployment problems.

Better:

This pattern causes deployment problems. For example, the build now depends on runtime environment variables that are not present in CI.

### Metric check

When performance, scale, speed, size, cost, or frequency is mentioned, prefer measurable detail.

Bad:

The new setup is much faster.

Better:

The new setup reduces cold build time from 42 seconds to 17 seconds.

If an exact number is not available, use a bounded qualitative statement only if it is still honest and useful.

Example:

The rebuild is visibly faster in local development because only changed modules are compiled.

### Source check

Do not use vague references such as:

experts say  
observers claim  
industry reports suggest

If a source matters, name it directly.

Better:

The Node.js documentation recommends this pattern for ESM package exports.

If no source can be named, remove the attribution.

### Observation check

If the statement comes from direct experience, say so plainly.

Example:

In this repository, the failure only occurs when the script is started through cron.

This is better than pretending the claim is universal.

## Claim strength rules

Match the strength of the wording to the available evidence.

### Strong claims require strong support

Avoid unsupported wording such as:

always  
never  
proves  
guarantees  
fundamentally  
clearly

Use narrower wording when evidence is limited.

Examples:

often  
in this project  
in our tests  
under this setup  
tends to

### Remove inflated conclusions

Bad:

This changes everything about the workflow.

Better:

This removes three manual steps from the release process.

## Technical writing preference

When editing technical prose, prefer this order:

1. mechanism
2. example
3. metric
4. source

Use the strongest available support without inventing certainty.

## What to remove

Delete or rewrite sentences that:

- make broad claims without support
- use vague praise without evidence
- state conclusions without showing cause
- imply consensus without naming a source
- repeat a claim in different words without adding proof

## Final validation

Before returning the text, verify:

- every important claim is grounded
- every comparative claim has a basis
- every performance claim is measurable or explicitly observational
- every attributed claim names a source or removes the attribution
- every conclusion follows from evidence already presented
