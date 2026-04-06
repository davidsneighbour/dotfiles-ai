# GitHub Token System (Agent Instructions)

## Purpose

This project uses a **role-based GitHub token system** with a strict separation of concerns.

Agents MUST:

* never hardcode token variable names
* never introduce new token variables
* always use the provided helper tooling
* always select tokens based on *capability*, not convenience

## Token Model

Tokens are defined in `.env` using this fixed schema:

```bash
GITHUB_TOKEN_READ_PUBLIC=''
GITHUB_TOKEN_READ_PRIVATE=''

GITHUB_TOKEN_CONTENT_PUBLIC=''
GITHUB_TOKEN_CONTENT_PRIVATE=''

GITHUB_TOKEN_ADMIN_PUBLIC=''
GITHUB_TOKEN_ADMIN_PRIVATE=''
```

Optional defaults:

```bash
GITHUB_DEFAULT_ROLE='read'
GITHUB_DEFAULT_VISIBILITY='public'
```

## Token Roles (MANDATORY SEMANTICS)

Agents MUST use the correct role:

### `read`

Use for:

* reading repository metadata
* listing labels, issues, PRs
* inspecting repository state
* dry-run operations

Do NOT use for:

* any mutation (even if technically possible)

### `content`

Use for:

* reading/writing repository files
* committing changes
* pushing branches
* modifying content inside repositories

Do NOT use for:

* repository settings or administrative APIs

### `admin`

Use for:

* labels (create/update/delete)
* repository settings
* secrets and configuration
* administrative API endpoints

## Visibility

### `public`

Use when:

* working with public repositories

### `private`

Use when:

* accessing private repositories

Agents MUST NOT guess visibility.
If unclear:

* prefer `public`
* or require explicit configuration

## Token Access (MANDATORY)

Tokens are accessed ONLY via the helper:

```bash
github-token
```

### Allowed subcommands

#### Run a command with a token

```bash
github-token run --role <role> --visibility <visibility> -- <command>
```

Example:

```bash
github-token run --role admin --visibility public -- gh api /repos/OWNER/REPO/labels
```

#### Export token to environment

```bash
eval "$(github-token print-env --role <role> --visibility <visibility>)"
```

Only use when:

* a tool cannot be wrapped directly

#### Get raw token (RARE)

```bash
github-token get --role <role> --visibility <visibility>
```

Avoid unless strictly necessary.

## GitHub CLI Usage

Agents MUST prefer:

```bash
github-token run --role <role> --visibility <visibility> -- gh <command>
```

NOT:

```bash
GH_TOKEN=... gh ...
```

NOT:

```bash
export GH_TOKEN=...
```

## Prohibited Patterns

Agents MUST NOT:

* use:

  * `GH_TOKEN=...`
  * `GITHUB_TOKEN=...`
* reference:

  * `GITHUB_REPOMANAGEMENT_TOKEN`
  * `GITHUB_READ_TOKEN`
  * any legacy token names
* introduce new token variables
* bypass `github-token` helper
* use a higher privilege role than required

## Role Selection Rules

### Read-only operations

→ `read`

### Any mutation of repository content

→ `content`

### Any repository configuration or metadata mutation

→ `admin`

## Dry-run vs Apply

If a script supports modes:

* `--dry-run`
  → MUST use `read`

* `--apply`
  → MUST escalate:

  * content changes → `content`
  * repo settings → `admin`

## Script Design Requirements

All new scripts MUST:

* use `github-token run`
* expose options when appropriate:

  * `--github-role`
  * `--github-visibility`
* default to:

  * `read`
  * `public`

## Migration Rules (IMPORTANT)

When refactoring existing code:

### Replace

```bash
GH_TOKEN="${SOME_TOKEN}" gh api ...
```

### With

```bash
github-token run --role <role> --visibility <visibility> -- gh api ...
```

## Security Model

This system enforces:

* least privilege access
* explicit capability selection
* no implicit token reuse
* centralised credential handling

Agents MUST preserve this model.

## Extension Rules

Agents MAY extend the system ONLY if:

* absolutely necessary
* consistent with role-based design
* documented in this file

Examples:

* adding `--token-type` in future
* adding visibility auto-detection

Agents MUST NOT:

* introduce ad-hoc shortcuts
* collapse roles into one token

Do **not** rely on agents to deduce pitfalls.
This is exactly the kind of thing LLMs get subtly wrong over time.

You should explicitly encode them.

Below is an **add-on section** you can append to your existing instruction file.

## Common pitfalls and failure modes (MANDATORY)

Agents MUST understand and actively avoid the following issues.

### 1. Wrong role selection

#### Symptom

* 403 errors
* unexpected permission failures

#### Cause

Using:

* `read` for a mutation
* `content` for admin operations

#### Rule

* read-only → `read`
* file changes → `content`
* repo configuration → `admin`

Agents MUST NOT "try higher roles" blindly.

### 2. Missing repository scope (private tokens)

#### Symptom

* 404 (not found) on existing repos
* inconsistent access between repos

#### Cause

Fine-grained token does not include the target repository.

#### Rule

Agents MUST assume:

* private tokens are **repo-scoped**
* failure may be caused by missing repo selection, not wrong API usage

Agents MUST NOT:

* assume the repo does not exist
* silently retry with a different token

### 3. Missing required permission

#### Symptom

* 403 "Resource not accessible"
* specific API endpoints failing

#### Common cases

* label creation → requires **Administration: write**
* file changes → requires **Contents: write**

#### Rule

Agents MUST:

* map operation → required permission → role

### 4. Using the wrong visibility

#### Symptom

* public repo works, private fails
* or vice versa

#### Cause

Using `public` token for private repo or vice versa

#### Rule

Agents MUST:

* use `private` for any private repo
* not assume visibility
* require explicit configuration if unclear

### 5. Over-privileged token usage

#### Symptom

* everything works, but violates system design

#### Cause

Using:

* `admin` for simple reads
* `admin` for content changes

#### Rule

Agents MUST:

* use the **lowest sufficient role**
* not default to `admin`

### 6. Bypassing the helper

#### Symptom

* inconsistent behaviour across scripts
* broken authentication in CI or shells

#### Cause

Using:

```bash
GH_TOKEN=...
```

#### Rule

Agents MUST ONLY use:

```bash
github-token run ...
```

### 7. Mixing Git and GitHub API authentication

#### Symptom

* `gh api` works
* `git push` fails (or vice versa)

#### Cause

Different authentication mechanisms:

* `gh api` → uses `GH_TOKEN`
* `git push` → uses git credential helper / HTTPS / SSH

#### Rule

Agents MUST:

* treat GitHub API and Git transport as separate concerns
* not assume `github-token` automatically fixes `git push`

### 8. Dry-run using write/admin tokens

#### Symptom

* dry-run unnecessarily requires high permissions

#### Rule

* `--dry-run` → MUST use `read`
* `--apply` → escalate only if needed

### 9. Creating unnecessary tokens

#### Symptom

* `.env` becomes cluttered again

#### Rule

Agents MUST:

* reuse existing role/visibility combinations
* NOT introduce new token variables


### 10. Silent fallback behaviour

#### Symptom

* script "works" but uses wrong token

#### Cause

fallback logic like:

* try read → fallback to admin

#### Rule

Agents MUST:

* fail explicitly
* NOT fallback to higher privilege automatically


## Debugging guidance

When authentication fails, agents MUST check in this order:

1. correct role?
2. correct visibility?
3. repo included in token scope?
4. required permission enabled?
5. using `github-token` helper?




## Summary

Always:

* choose role based on action
* choose visibility based on repo
* use `github-token run`

Never:

* access tokens directly
* guess privileges
* bypass the helper

If a GitHub operation fails:

Agents MUST assume **configuration issue first**, not API misuse.
