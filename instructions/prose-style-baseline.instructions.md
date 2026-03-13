---
name: Prose style baseline
description: Baseline stylistic fingerprint for prose generated in this repository
applyTo: "**/*.md"
priority: medium
author: Patrick Kollitsch
---

# Prose style baseline

This instruction defines the stylistic baseline used when generating prose.

The goal is not generic "good writing".  
The goal is to approximate the author's natural writing style.

The baseline SHOULD evolve over time as the author's writing evolves.

This instruction complements the prose compiler pipeline.

# General voice

Generated prose MUST resemble technical writing produced by an experienced engineer.

The voice MUST be:

- calm
- analytical
- explanatory
- precise

The voice MUST NOT be:

- motivational
- promotional
- theatrical
- keynote-style

# Audience assumption

The text SHOULD assume that the reader:

- is technically literate
- understands common engineering concepts
- does not require pedagogical simplification

The system MUST NOT adopt a teacher-student tone unless explicitly requested.

# Sentence rhythm

Preferred sentence characteristics:

- medium-length sentences
- mostly declarative statements
- occasional longer explanatory sentences

The system SHOULD avoid:

- chains of very short sentences
- rhetorical fragments
- overly complex nested sentences

Target sentence length:

15–22 words on average.

# Paragraph structure

Paragraphs SHOULD typically:

- introduce one idea
- explain the mechanism
- show implications or consequences

Paragraphs SHOULD usually contain:

3–5 sentences.

The system SHOULD avoid:

- single-sentence paragraphs used for drama
- excessively long paragraphs

# Vocabulary

Vocabulary SHOULD favour:

- common engineering terminology
- precise technical nouns
- verbs that describe mechanisms

The system MUST avoid inflated vocabulary.

Examples to avoid:

delve  
leverage  
utilize  
harness  
synergy  
paradigm  
tapestry  
landscape  

Preferred alternatives:

use  
show  
build  
explain  
operate  

# Argument style

Arguments SHOULD focus on:

- mechanisms
- observable behaviour
- practical implications

The system SHOULD prefer explanations that answer:

why something works  
how something fails  
what consequence follows

Arguments MUST avoid:

- abstract generalisations
- grand narratives
- philosophical speculation unless explicitly requested.

# Evidence preference

When making claims, the system SHOULD prioritise:

1. mechanism
2. example
3. measurable outcome
4. source citation

Statements SHOULD be grounded in observable behaviour whenever possible.

# Metaphor usage

Metaphors SHOULD be used sparingly.

When used, they MUST clarify a mechanism.

Metaphors MUST NOT be repeated across the entire document.

# Tone control

Tone MUST remain proportional to the subject.

Minor implementation details MUST NOT be framed as transformative events.

Examples of prohibited exaggeration:

- "changes everything"
- "defines the next era"
- "revolutionises the industry"

# Structural signals

The system SHOULD avoid explicit structural markers such as:

- "in conclusion"
- "to sum up"
- "in this section"

Structure SHOULD emerge naturally from the writing.

# Formatting preferences

Prose output MUST:

- use straight quotes
- avoid decorative unicode characters
- avoid bold-first bullet formatting
- avoid excessive em-dashes

# Writing density

The baseline writing style prefers:

- high information density
- minimal repetition
- concrete examples

The system SHOULD prefer fewer paragraphs with stronger content rather than longer padded articles.

# Author style reference

When possible, generated prose SHOULD resemble:

- technical blog posts written by the repository owner
- internal documentation written by the repository owner
- explanatory notes written by the repository owner

If a conflict arises between this baseline and the prose compiler pipeline, the pipeline rules take precedence.
