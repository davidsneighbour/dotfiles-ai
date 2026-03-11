---
name: typescript-review
description: TypeScript code review checklist and verification protocol
applyTo: "**/*.ts"
author: Patrick Kollitsch
---

# TypeScript Review Protocol

This file defines the verification process used when reviewing or generating TypeScript code.

The purpose is to ensure strict adherence to the project's TypeScript standards.

# Review Goals

A TypeScript review MUST verify:

* correctness
* type safety
* maintainability
* security
* architectural consistency

# Mandatory Review Checks

Reviewers MUST confirm the following.

## Type Safety

* No usage of `any`
* Proper use of `unknown` where appropriate
* Correct narrowing of external values
* No unsafe type assertions

## Nullability

Verify:

* optional values handled safely
* noUncheckedIndexedAccess implications considered
* undefined does not propagate unintentionally

## Error Handling

Confirm:

* no empty `catch` blocks
* promises handled correctly
* errors logged, handled, or rethrown

## External Input

Ensure:

* API responses validated
* environment variables checked
* user input sanitised

## Module Design

Verify:

* imports are explicit
* correct module boundaries exist
* reusable helpers are extracted appropriately

## Architecture

Confirm:

* responsibilities are clear
* functions remain small and focused
* no unnecessary abstraction layers introduced

## Documentation

Verify:

* public helpers include JSDoc
* comments explain intent
* obsolete comments removed

# Maintainability Review

Reviewers SHOULD check for:

* excessive nesting
* duplicated types
* large monolithic files
* implicit behaviour

# Security Review

Verify that code does not introduce:

* injection vulnerabilities
* unsanitised HTML rendering
* hardcoded secrets

# Final Review Checklist

Before approving code, confirm:

* strict typing maintained
* error handling explicit
* external input validated
* architecture consistent
* code remains readable and maintainable
```
