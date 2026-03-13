---
name: Human prose lint
description: Detect and remove AI writing tropes in generated prose
applyTo: "**/*.md"
priority: medium
author: Patrick Kollitsch
---

# Human prose lint pass

After generating prose, run a verification pass.

The goal is to remove common AI writing patterns.

# Check for rhetorical templates

Rewrite sentences that follow these patterns:

It's not X. It's Y.  
Not X. Not Y. Just Z.  
The result? Something.  
The real problem? Something.

Replace with a direct statement.

# Check for filler transitions

Remove phrases such as:

It's worth noting  
Importantly  
Interestingly  
Notably

They rarely add information.

# Check for teaching voice

Remove phrases like:

Let's explore  
Let's unpack  
Let's break this down  
Think of it as

Rewrite using neutral exposition.

# Check for exaggerated stakes

Rewrite sentences containing:

transform everything  
define the next era  
change the future  
revolutionize everything

Replace with precise claims.

# Check for invented concept labels

Look for patterns such as:

*word* paradox  
*word* trap  
*word* divide  
*word* creep

If the concept is not established terminology, rewrite the explanation.

# Check for repetition

Verify that:

- paragraphs do not restate earlier points
- examples are not repeated
- the thesis is not rephrased multiple times

Remove redundant passages.

# Check punctuation style

Replace:

smart quotes  
unicode arrows  
excessive em dashes

with:

straight quotes  
->  
minimal punctuation

# Length sanity check

If the text repeats the same idea across multiple sections, condense it.

Prefer shorter, denser writing.

# Final validation

The final text must satisfy:

- no rhetorical gimmicks
- no inflated vocabulary
- no dramatic transitions
- no teaching tone
