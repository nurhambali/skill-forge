---
name: issue-handler
description: Handle GitLab issues systematically — analyze, plan, implement, test, commit, close, merge, and cleanup. GitLab project ID 3.
---

# GitLab Issue Handler

Handle GitLab issues systematically — from analysis to resolution.

## Overview

This skill provides a structured workflow for handling GitLab issues. It covers the entire lifecycle: analyze, plan, implement, test, commit, close, merge, and cleanup.

## Rules

- **Branch:** Create feature branch from `dev`. Never commit directly to `main`.
- **GitLab Project ID:** Always use project ID `3` for all `glab` commands.
- **Commit Style:** Conventional Commits `type(scope): description`.
- **Close with Comment:** Always add a comment to the issue when closing: `glab issue comment <id> --message "..."`.
- **Branch Cleanup:** ALWAYS delete the feature branch (local + remote) after merging to `dev`.
- **Database Rules:** Do NOT touch staging tables, stored procedures, or stable upload/recon database logic unless specified.

## Workflow

### Single Issue

```
1. Read issue details (glab issue view <id>)
2. Analyze problem & check codebase
3. Implement minimal changes (follow coding conventions)
4. Test and verify (run lint/test if available)
5. Commit with scope (e.g. feat(license): add table)
6. Push to feature branch
7. Close issue with comment (glab issue close <id>)
8. Merge feature branch to dev
9. Delete feature branch (local + remote)
10. Update wiki
```

### Merge & Cleanup

After all tasks complete:

```bash
# Merge to dev
git checkout dev
git merge feat/feature-name
git push origin dev

# Delete feature branch (local + remote)
git branch -d feat/feature-name
git push origin --delete feat/feature-name

# Close MR if exists
glab mr close <mr_id>
```

**NEVER leave unmerged feature branches.** If branch is merged, delete it immediately.

## Coding Conventions

### Backend Python (FastAPI)
- **Response:** Plain dicts, no envelope.
- **Error:** `raise HTTPException(code, detail)` (Indonesian/English mixed).
- **Database:** SQLAlchemy AsyncSession via `Depends(get_db)` OR raw asyncpg.
- **Helpers:** Private helpers prefixed with underscore.

### Frontend JavaScript (Next.js)
- **Directives:** `"use client";` at top.
- **Pure JavaScript:** No TypeScript.
- **CSS:** CSS variables only (`var(--text-1)` etc.), no new UI libraries.
- **State:** `useState` + `useEffect` + localStorage, no Redux.

### Frontend-API TypeScript (Elysia)
- **Pattern:** `create*Routes(adapter)` factory function.
- **Error:** `{ error: string }` + `set.status = 4xx`.
- **Auth:** `guard(ctx, resource, action)` inside handlers.
