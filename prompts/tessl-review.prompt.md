You are working inside this repository.

## Task

Review and fix the Tessl skill at:

$SKILLPATH

## Procedure

1. Run:

```bash
npx tessl skill review $SKILLPATH
```

2. Read the full output.

3. Fix the skill according to:

  - validation errors
  - warnings
  - judge evaluation weaknesses
  - explicit suggestions

Edit the skill files directly.

4. Run the review again:

```bash
npx tessl skill review $SKILLPATH
```

Repeat the fix → review cycle until:

- no validation errors remain
- warnings are resolved where reasonable
- the skill description, trigger terms, and workflow clarity are improved.

## Optimization step

If Tessl supports optimization, run:

```bash
npx tessl skill review --optimize $SKILLPATH
```

If it produces improved content:

- inspect the changes
- keep the improvements
- refine them manually if necessary
- re-run the review command afterwards.

## Rules

- Always run the Tessl command before making conclusions.
- Do not invent fixes unrelated to Tessl feedback.
- Prefer minimal, precise edits.
- Do not add filler text just to increase scores.

## Completion

Before finishing:

1. Run the review command one final time:

```bash
npx tessl skill review $SKILLPATH
```

2. Confirm the final result.

3. Summarize briefly:

  - what was fixed
  - what improved
  - what suggestions were intentionally ignored.
