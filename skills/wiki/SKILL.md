---
name: wiki
description: Maintain an LLM-maintained project wiki at .wiki/ — auto-update after code changes, create pages for new concepts, lint for contradictions.
---

# LLM Wiki Auto-Maintenance

Maintain a persistent, structured knowledge base for the project. Pattern from [Karpathy's LLM Wiki](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f).

## Overview

The wiki is a directory of LLM-generated markdown files (`.wiki/`) that serves as the project's knowledge base. The LLM maintains it automatically — you never write wiki pages manually.

## When to Use

- **After code changes** — update relevant wiki pages
- **After ingesting new code/docs** — update wiki + index + log
- **When asked about architecture** — read wiki first, then answer
- **Periodically** — lint wiki for consistency

## Directory Structure

```
.wiki/
  index.md          # content catalog (navigation)
  log.md            # chronological record
  architecture.md   # system architecture
  services.md       # backend services overview
  routers.md        # API endpoints
  models.md         # data models
  frontend.md       # frontend structure
  config.md         # configuration
  issues.md         # known issues & solutions
```

## Operations

### 1. Update (after code changes)

When code is modified:

1. Identify which wiki pages are affected
2. Read those pages
3. Update content to reflect changes
4. Update `.wiki/index.md` if pages added/removed
5. Append entry to `.wiki/log.md`

**Example log entry:**
```markdown
## [2026-05-29] update | Services

- Updated services.md: added retry logic to Docling provider
- Updated architecture.md: noted Redis rate limiting
```

### 2. Query (when asked about architecture)

When user asks about architecture/system:

1. Read `.wiki/index.md` first
2. Find relevant pages
3. Read those pages
4. Answer with citations (reference page names)

### 3. Lint (periodic health check)

Check for:
- Contradictions between pages
- Stale claims (code changed but wiki not updated)
- Orphan pages (no inbound links)
- Missing cross-references
- Important concepts without their own page

## Rules

- **Never write wiki pages manually** — LLM owns this layer
- **Always update after code changes** — keep wiki current
- **Read index first** — when answering architecture questions
- **Append to log** — every ingest/update gets a log entry
- **Use consistent format** — follow existing page structure

## Integration with AGENTS.md

The wiki schema is defined in `AGENTS.md` under "Project Wiki". This skill implements the auto-update behavior described there.

## Example Update Flow

```
User: "Fix retry logic in Docling provider"
↓
LLM: Makes code changes to docling_provider.py
↓
LLM: Auto-updates wiki:
  1. Read .wiki/services.md
  2. Update Docling provider section
  3. Append to .wiki/log.md
  4. Update .wiki/index.md if needed
↓
LLM: "Done. Wiki updated."
```

## Tips

- Keep pages focused — one topic per page
- Use cross-references — link related pages
- Update index when adding/removing pages
- Log every change — helps track wiki evolution
- Lint periodically — catch stale content early

---

*This skill auto-maintains the project wiki. The LLM updates it after every code change.*
