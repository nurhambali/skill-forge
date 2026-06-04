---
name: consistency-checker
description: Check and maintain codebase consistency — naming conventions, patterns, imports, error handling, and more.
---

# Codebase Consistency Checker

Check and maintain codebase consistency across the project.

## Overview

This skill checks for consistency issues in the codebase: naming conventions, patterns, license checks, imports, error handling, and more.

## Rules

- **License Checks:** Ensure all OCR-related code/pages are gated behind the license system (`hasOcr` in frontend, backend license verification).
- **No TypeScript in Frontend:** Frontend MUST use pure JavaScript (`.js`).
- **No Redundant Envelopes:** Backend endpoints return plain dicts, not nested under status/success keys.
- **Language:** English comments and docstrings, mixed Indonesian/English error messages.

## Checkpoints

1. **Backend Routing:** Router prefix and tags set, correct `APIRouter` usage.
2. **Frontend State:** `useState` + `useEffect` + localStorage used consistently.
3. **Frontend API Calls:** `apiFetch` for backend, `configFetch` for config API.
4. **Auth Guards:** Permissions correctly validated inside route handlers.
