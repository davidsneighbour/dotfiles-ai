# AI files of @davidsneighbour

Agents perform work, instructions constrain behaviour, prompts request tasks, and skills provide reusable methods.

## Agents

## Instructions

## Prompts

## Skills

## VS Code AI Symlink Helper

Use `scripts/ai-vscode-linker.sh` to create symlinks from this repository (expected at `~/.ai`) into the current folder's `.vscode/`.

Examples:

```bash
# one-time setup
~/.ai/linker.sh setup

# interactive linking in current directory
linker.sh
```

The interactive menu supports:

- linking full folders (`agents`, `instructions`, `prompts`, `skills`) to `.vscode/<name>`
- selecting single items (files or folders) in each category and linking them individually with clean display names
