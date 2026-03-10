# verification.instructions.md

## Purpose

This instruction defines the verification protocol that agents must follow before returning results to the user.  
Its purpose is to prevent incomplete work, unchecked assumptions, and silent failures.

The protocol enforces a verification loop, explicit requirement checking, and clear reporting of blockers.

Unless explicitly overridden by a more specific instruction file, this protocol applies to all tasks.

## Default verification protocol (compact version)

This protocol MUST be executed before returning a final result.

1. Re-read the full request
   * Re-check the complete task specification.
   * Include any corrections or clarifications made later in the conversation.
   * Treat the latest user instruction as authoritative if it overrides earlier wording.

2. Identify requirements
   * Extract all explicit requirements from the request.
   * Identify relevant implicit quality expectations such as correctness, completeness, formatting, consistency, and edge-case handling.

3. Verify instead of assuming
   * Do not claim a task is complete based on intention.
   * Verify results using actual evidence where possible:
     * execution
     * inspection
     * output validation
     * format verification
     * behaviour testing

4. Rework failures
   * If any requirement fails verification, fix the issue.
   * After fixing, repeat the verification process.
   * Do not assume previously passing parts still pass.

5. Respect the planned process
   * Review whether all planned steps were followed in the intended order.
   * If steps were skipped, reordered, or replaced, explicitly state:
     * what changed
     * why it changed

6. Stop after repeated failure
   * If the same issue persists after **3 full fix-and-verify cycles**, stop the process.
   * Report the blocker clearly, including:
     * the failing requirement
     * attempted fixes
     * the likely cause

7. Return only verified results
   * Only return the final result when:
     * all requirements have verified evidence of passing, or
     * unresolved blockers have been explicitly reported.

## Extended verification protocol (for complex tasks)

This extended protocol MUST be used for:

* code generation
* file creation or modification
* scripts and automation
* configuration changes
* multi-step workflows
* tasks where failure could propagate silently

The following additional verification steps apply.

### Requirement mapping

* Identify every explicit requirement in the task.
* Map each requirement to the exact implementation element that satisfies it.

Examples:

* file path
* function
* configuration section
* output section
* command behaviour

### Implementation traceability

If code or files were modified:

* map each requirement to the relevant implementation location
* explain how the implementation satisfies the requirement
* identify any requirement that could not be implemented or verified

### Evidence-based verification

Verification MUST be based on observable evidence rather than assumptions.

Examples:

* confirming file structure
* validating CLI parameters
* confirming output formatting
* reviewing error handling paths
* testing expected behaviour and edge cases

### Full re-verification after fixes

If any issue is found:

* fix the issue
* re-run the **entire verification process**
* do not assume unaffected sections remain correct

### Failure escalation rule

After **3 full fix-and-verify cycles** with the same unresolved problem:

* stop attempting silent fixes
* report the blocker
* provide a diagnosis of the cause
* suggest possible next actions if available

Returning unverified or partially broken work is prohibited.

## Verification summary requirement

For complex tasks, the response SHOULD include a concise verification summary containing:

* requirements checked
* verification evidence
* confirmation of successful completion or
* disclosure of unresolved blockers

The goal is transparency of verification, not excessive verbosity.

## Guiding principle

Agents MUST NOT rely on assumptions when verifying work.

Completion claims must always be backed by verification evidence or explicit disclosure of limitations.
