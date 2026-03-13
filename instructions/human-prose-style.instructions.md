---
name: Human prose style
description: Constraints for writing concise human-readable prose for blogs and technical writing
applyTo: "**/*.md"
priority: high
author: Patrick Kollitsch
---

# Human prose style rules

These rules constrain how prose text is written.  
They apply to:

- blog posts
- essays
- documentation prose
- newsletters
- long-form explanations

They do NOT apply to:

- code
- command examples
- configuration snippets
- prompts
- structured documentation tables

The goal is concise writing that reads like a human engineer wrote it.

# Core writing principles

## Prefer simple vocabulary

Use the most common word that expresses the idea.

Avoid inflated vocabulary such as:

delve  
leverage  
utilize  
harness  
robust  
streamline  
ecosystem  
landscape  
tapestry  
paradigm  
synergy

Prefer:

use  
show  
build  
system  
environment  
structure

## Remove filler adverbs

Avoid unnecessary modifiers such as:

quietly  
deeply  
fundamentally  
remarkably  
arguably  
significantly

If the sentence works without the adverb, remove it.

## Use direct sentence structures

Prefer clear statements.

Avoid rhetorical constructions:

- It's not X. It's Y.
- Not X. Not Y. Just Z.
- The result? Something dramatic.

These patterns create artificial emphasis.

## Avoid teaching tone

Do not assume the reader needs guidance through the argument.

Avoid phrases like:

Let's break this down  
Let's unpack this  
Let's explore  
Think of it as  
Imagine a world where

Write as if the reader already understands the topic.

## Avoid manufactured suspense

Avoid dramatic transitions such as:

Here's the kicker  
Here's the thing  
Here's what most people miss

State the point directly.

## Avoid repetitive rhetorical structures

Limit repeated patterns such as:

- repeated sentence openings
- tricolon chains
- slogan-style phrasing

Example to avoid:

Products solve problems.  
Platforms create ecosystems.  
Systems change everything.

Use normal prose instead.

## Do not inflate stakes

Avoid claims that something will:

change everything  
define the next era  
reshape how we think about everything  
transform civilization

Keep arguments proportional to the subject.

## Avoid invented analytical labels

Do not create compound labels such as:

the acceleration trap  
the supervision paradox  
the productivity divide

Explain the mechanism instead of inventing a name.

## Avoid vague authority references

Never write:

experts say  
observers claim  
industry reports suggest

Name the source or remove the claim.

## Avoid padding

Each paragraph must introduce new information.

Avoid:

- repeating the thesis
- restating earlier arguments
- filling space with paraphrases

Concise writing is preferred over completeness.

# Paragraph structure guideline

A typical paragraph should follow:

Observation  
Explanation  
Implication

Example:

Bad:

The result? Devastating.

Better:

The build fails because the dependency graph contains circular imports. This prevents incremental compilation and forces full rebuilds.

# Formatting rules

## Punctuation

Avoid excessive:

—  
→  
smart quotes

Prefer:

-  
->  
"  
'

## Lists

Avoid bold-first bullets such as:

**Security**:  
**Performance**:  

Use normal list items instead.

# Writing density

Target characteristics:

average sentence length: 15–20 words  
minimal metaphors  
high information density

Prefer:

facts  
mechanics  
examples

Avoid:

motivational phrasing  
futuristic speculation  
generic statements

# Final requirement

The text should read like an engineer explaining a system to another engineer.
