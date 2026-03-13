You are working inside this repository.

Target skill ($SKILLPATH): input value here

1. Run:

```bash
npx tessl skill review $SKILLPATH
```

2. Read the output and fix the skill files according to:

- validation errors
- warnings
- judge suggestions

3. Run the review again and iterate until issues are resolved or meaningfully improved.

4. If available run:

```bash
npx tessl skill review --optimize $SKILLPATH
```

Inspect the optimization result, keep useful improvements, refine if needed, then run the review again.

Rules:

- Always run the tessl command before conclusions.
- Only implement fixes related to tessl feedback.
- Prefer minimal precise edits.

Finish by running:

```bash
npx tessl skill review $SKILLPATH
```

Return a short summary of fixes and the final `tessl` result.
