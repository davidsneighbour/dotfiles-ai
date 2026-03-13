---
name: Prose compiler master
description: Multi-pass editorial pipeline for human-readable technical prose
applyTo: "**/*.md"
priority: high
author: Patrick Kollitsch
---

# Prose compiler master

This instruction defines the editorial pipeline used for generating prose.

The pipeline MUST be applied to:

- blog posts
- essays
- documentation prose
- newsletters
- long-form explanations

The pipeline MUST NOT modify:

- code
- command examples
- configuration files
- API schemas
- structured reference tables

# Objective

Generated prose MUST satisfy the following properties:

- concise
- mechanically explained
- specific
- proportionate in tone
- readable for experienced practitioners

The voice SHOULD resemble an engineer explaining a system to another engineer.

The output MUST avoid rhetorical or marketing-style writing.

# Pipeline

The following passes MUST be executed in order:

1. Structure pass  
2. Clarity pass  
3. Evidence pass  
4. Trope lint  
5. Compression pass  
6. Final validation

No pass MAY be skipped when generating prose.

# Pass 1: Structure

The structure pass MUST organise the document before stylistic edits occur.

## Section flow

Sections SHOULD follow the progression:

Problem  
Mechanism  
Implication

## Paragraph flow

Paragraphs SHOULD follow:

Observation  
Explanation  
Implication

## Structural rules

The system MUST:

- merge sections that repeat the same argument
- remove sections used only as transitions
- eliminate filler transitions such as:
  - "before we dive in"
  - "at a high level"
  - "in this section"

The system MUST NOT disguise listicles as prose using phrases such as:

- "the first"
- "the second"
- "the third takeaway"

# Pass 2: Clarity

The clarity pass MUST simplify vocabulary and sentence structure.

## Vocabulary

Inflated vocabulary MUST be replaced with plain alternatives.

Words that MUST NOT be used unless technically required include:

delve  
leverage  
utilize  
harness  
robust  
streamline  
landscape  
tapestry  
paradigm  
synergy  

The system SHOULD prefer common verbs such as:

use  
show  
build  
explain

## Sentence construction

Sentences SHOULD:

- be direct
- avoid unnecessary passive voice
- avoid filler phrases

The following filler phrases MUST be removed:

- it is worth noting
- it is important to mention
- in many ways
- at the end of the day

Unnecessary adverbs such as the following SHOULD be removed:

quietly  
deeply  
fundamentally  
remarkably  
arguably

# Pass 3: Evidence

Claims MUST be grounded in support.

The system SHOULD prefer evidence in the following order:

1. mechanism
2. example
3. metric
4. named source
5. direct observation

## Evidence rules

The system MUST NOT:

- make broad claims without support
- attribute claims to unnamed authorities
- state performance improvements without measurable basis when available

If a claim cannot be supported, the system MUST:

- narrow the claim, or
- remove the claim.

## Claim strength

Absolute language MUST NOT be used without strong evidence.

Examples of prohibited unsupported wording:

always  
never  
guarantees  
proves  
clearly

When evidence is limited, the system SHOULD prefer narrower wording such as:

often  
in this project  
under this setup  
in our tests

# Pass 4: Trope lint

The system MUST remove common AI writing tropes.

The following patterns MUST be rewritten:

- "It's not X. It's Y."
- "Not X. Not Y. Just Z."
- "The result? X."
- "The real problem? X."

The following transitions MUST be removed:

- "Here's the kicker"
- "Here's the thing"
- "Here's what most people miss"

The system MUST NOT use pedagogical phrasing such as:

- "Let's break this down"
- "Let's explore"
- "Let's unpack"

Invented analytical labels MUST NOT be used.

Examples include:

- acceleration trap
- supervision paradox
- productivity divide

Stake inflation MUST NOT occur.

Ordinary technical observations MUST NOT be framed as historical turning points.

# Pass 5: Compression

The compression pass MUST increase information density.

The system MUST:

- remove repeated arguments
- remove paraphrase padding
- remove empty emphasis sentences
- merge short related sentences when appropriate

Paragraphs that only restate earlier points MUST be removed.

## Target characteristics

Generated prose SHOULD have:

- average sentence length of approximately 15–20 words
- minimal metaphor usage
- high information density

Each paragraph SHOULD perform a single explanatory function.

# Final validation

Before returning prose, the system MUST verify the following.

## Structure validation

- each section introduces new information
- the argument progresses logically
- no section exists solely to announce another section

## Clarity validation

- vocabulary is plain and specific
- filler transitions are removed
- inflated verbs are removed

## Evidence validation

- important claims are grounded
- comparative claims have support
- attributed claims name sources or remove attribution

## Trope validation

- rhetorical gimmicks are absent
- pedagogical voice is absent unless explicitly requested
- dramatic transitions are absent

## Compression validation

- paragraphs do not repeat earlier content
- emphasis sentences without information are removed
- the text is shorter without losing meaning

# Formatting rules

Prose output MUST:

- use straight quotation marks
- avoid unicode arrows
- avoid excessive em dashes
- avoid bold-first bullet formatting

# Tone

The tone MUST remain proportionate to the subject.

The system MUST NOT:

- inflate the significance of minor technical observations
- use motivational or keynote-style rhetoric
- adopt marketing language unless explicitly requested

# Result

The final text SHOULD read as:

calm  
specific  
edited  
human

The writing MUST not appear templated, performative, or padded.
