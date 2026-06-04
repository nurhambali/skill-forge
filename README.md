# AI Setup — Universal LLM Project Bootstrap

One script to setup any project for any LLM tool with wiki + skills.

## Install

```bash
git clone https://github.com/nurhambali/skill-forge.git /path/to/ai
bash /path/to/ai/setup-project.sh --help
```

## Quick Start

Use the same install commands whether you run them locally in a shell or through an AI tool that can execute terminal commands.

```bash
# OpenCode (skills as separate files)
bash /path/to/ai/setup-project.sh --opencode /path/to/project "Project Name"

# Claude Code (skills embedded in CLAUDE.md)
bash /path/to/ai/setup-project.sh --claude /path/to/project "Project Name"

# Kiro (AWS) (skills embedded in rules.md)
bash /path/to/ai/setup-project.sh --kiro /path/to/project "Project Name"

# Cursor (skills embedded in .cursorrules)
bash /path/to/ai/setup-project.sh --cursor /path/to/project "Project Name"

# Copilot (skills embedded in COPILOT.md)
bash /path/to/ai/setup-project.sh --copilot /path/to/project "Project Name"

# Windsurf (Codeium) (skills embedded in .windsurfrules)
bash /path/to/ai/setup-project.sh --windsurf /path/to/project "Project Name"

# Amp (Sourcegraph) (skills embedded in .amprc)
bash /path/to/ai/setup-project.sh --amp /path/to/project "Project Name"

# Antigravity (AI tool, rules file)
bash /path/to/ai/setup-project.sh --antigravity /path/to/project "Project Name"

# Auto-detect
bash /path/to/ai/setup-project.sh /path/to/project "Project Name"
```

> If your AI assistant supports running shell commands, it can use the same install command directly. You can also copy the URL for `superpowers@git+https://github.com/obra/superpowers.git` into other tools that accept Git-based plugin sources.

## Supported Tools

| Tool | Flag | Config File | Skills | Wiki |
|------|------|-------------|--------|------|
| OpenCode | `--opencode` | `.opencode/AGENTS.md` | ✅ auto-download | ✅ auto-update |
| Claude Code | `--claude` | `CLAUDE.md` | ✅ embedded | ✅ via rules |
| GitHub Copilot | `--copilot` | `COPILOT.md` | ✅ embedded | ✅ via rules |
| Cursor | `--cursor` | `.cursorrules` | ✅ embedded | ✅ via rules |
| Kiro (AWS) | `--kiro` | `.kiro/rules.md` | ✅ embedded | ✅ via rules |
| Windsurf | `--windsurf` | `.windsurfrules` | ✅ embedded | ✅ via rules |
| Amp | `--amp` | `.amprc` | ✅ embedded | ✅ via rules |
| Antigravity | `--antigravity` | `.antigravity/rules.md` | ✅ embedded | ✅ via rules |

## What It Creates

```
project/
├── AGENTS.md                    # Universal config (all tools)
├── .opencode/                   # OpenCode only
│   ├── AGENTS.md
│   ├── opencode.json
│   └── skills/ (23 skills)      # Auto-downloaded
├── CLAUDE.md                    # Claude Code (with embedded skills)
├── COPILOT.md                   # Copilot (with embedded skills)
├── .cursorrules                 # Cursor (with embedded skills)
├── .kiro/rules.md               # Kiro (with embedded skills)
├── .windsurfrules               # Windsurf (with embedded skills)
├── .amprc                       # Amp (with embedded skills)
├── .antigravity/rules.md        # Antigravity (with embedded skills)
└── .wiki/                       # Universal (all tools)
    ├── index.md
    ├── log.md
    ├── architecture.md
    └── issues.md
```

## Skills (23 included)

Skills sourced from [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) + [obra/superpowers](https://github.com/obra/superpowers). Auto-downloaded on first run, embedded in all tool configs.

| Skill | Description | Source |
|-------|-------------|--------|
| [api-and-interface-design](https://github.com/addyosmani/agent-skills/blob/main/skills/api-and-interface-design/SKILL.md) | API design patterns | addyosmani/agent-skills |
| [ci-cd-and-automation](https://github.com/addyosmani/agent-skills/blob/main/skills/ci-cd-and-automation/SKILL.md) | CI/CD pipeline setup | addyosmani/agent-skills |
| [code-review-and-quality](https://github.com/addyosmani/agent-skills/blob/main/skills/code-review-and-quality/SKILL.md) | Code review best practices | addyosmani/agent-skills |
| [code-simplification](https://github.com/addyosmani/agent-skills/blob/main/skills/code-simplification/SKILL.md) | Code simplification | addyosmani/agent-skills |
| [context-engineering](https://github.com/addyosmani/agent-skills/blob/main/skills/context-engineering/SKILL.md) | Agent context optimization | addyosmani/agent-skills |
| [debugging-and-error-recovery](https://github.com/addyosmani/agent-skills/blob/main/skills/debugging-and-error-recovery/SKILL.md) | Debugging workflows | addyosmani/agent-skills |
| [deprecation-and-migration](https://github.com/addyosmani/agent-skills/blob/main/skills/deprecation-and-migration/SKILL.md) | Deprecation patterns | addyosmani/agent-skills |
| [documentation-and-adrs](https://github.com/addyosmani/agent-skills/blob/main/skills/documentation-and-adrs/SKILL.md) | Documentation & ADRs | addyosmani/agent-skills |
| [doubt-driven-development](https://github.com/addyosmani/agent-skills/blob/main/skills/doubt-driven-development/SKILL.md) | Verification before completion | addyosmani/agent-skills |
| [frontend-ui-engineering](https://github.com/addyosmani/agent-skills/blob/main/skills/frontend-ui-engineering/SKILL.md) | Production UI development | addyosmani/agent-skills |
| [git-workflow-and-versioning](https://github.com/addyosmani/agent-skills/blob/main/skills/git-workflow-and-versioning/SKILL.md) | Git practices | addyosmani/agent-skills |
| [idea-refine](https://github.com/addyosmani/agent-skills/blob/main/skills/idea-refine/SKILL.md) | Idea refinement | addyosmani/agent-skills |
| [incremental-implementation](https://github.com/addyosmani/agent-skills/blob/main/skills/incremental-implementation/SKILL.md) | Incremental implementation | addyosmani/agent-skills |
| [interview-me](https://github.com/addyosmani/agent-skills/blob/main/skills/interview-me/SKILL.md) | User interview | addyosmani/agent-skills |
| [performance-optimization](https://github.com/addyosmani/agent-skills/blob/main/skills/performance-optimization/SKILL.md) | Performance optimization | addyosmani/agent-skills |
| [planning-and-task-breakdown](https://github.com/addyosmani/agent-skills/blob/main/skills/planning-and-task-breakdown/SKILL.md) | Task planning | addyosmani/agent-skills |
| [security-and-hardening](https://github.com/addyosmani/agent-skills/blob/main/skills/security-and-hardening/SKILL.md) | Security review | addyosmani/agent-skills |
| [shipping-and-launch](https://github.com/addyosmani/agent-skills/blob/main/skills/shipping-and-launch/SKILL.md) | Shipping & launch | addyosmani/agent-skills |
| [source-driven-development](https://github.com/addyosmani/agent-skills/blob/main/skills/source-driven-development/SKILL.md) | Documentation-based coding | addyosmani/agent-skills |
| [spec-driven-development](https://github.com/addyosmani/agent-skills/blob/main/skills/spec-driven-development/SKILL.md) | Spec-first development | addyosmani/agent-skills |
| [test-driven-development](https://github.com/addyosmani/agent-skills/blob/main/skills/test-driven-development/SKILL.md) | TDD workflows | addyosmani/agent-skills |
| [using-agent-skills](https://github.com/addyosmani/agent-skills/blob/main/skills/using-agent-skills/SKILL.md) | Meta: how to use skills | addyosmani/agent-skills |
| [wiki](https://github.com/obra/superpowers/blob/main/skills/wiki/SKILL.md) | LLM-maintained knowledge base | obra/superpowers |

### Superpowers Plugin

Skills powered by [obra/superpowers](https://github.com/obra/superpowers) — the OpenCode skill framework.

```json
// ~/.config/opencode/opencode.json
{
  "plugin": [
    "superpowers@git+https://github.com/obra/superpowers.git"
  ]
}
```

> For new installs, omitting the `#tag` means the default branch is used, so the latest plugin source is fetched. To pin to a stable release, append a specific tag like `#v5.1.0`.

## How Wiki Works

The wiki (`.wiki/`) is a persistent memory system for LLM agents:

1. **First session**: agent reads `.wiki/index.md` → learns project architecture
2. **After code changes**: agent updates `.wiki/log.md` with changes
3. **After optimization**: agent updates `.wiki/architecture.md` + benchmark results
4. **After bugs**: agent adds to `.wiki/issues.md`
5. **New sessions**: agent reads wiki → knows everything from previous sessions

### Wiki Files

| File | Purpose | Updated When |
|------|---------|--------------|
| `.wiki/index.md` | Navigation catalog | Pages added/removed |
| `.wiki/log.md` | Chronological changelog | Every code change |
| `.wiki/architecture.md` | System design + benchmarks | Architecture changes |
| `.wiki/issues.md` | Known issues + solutions | Bugs found/fixed |

## Refresh Skills Cache (Optional)

Skills are auto-downloaded on first run. To force refresh:

```bash
bash /path/to/ai/sync-skills.sh
```

## Files

```
/path/to/ai/
├── README.md
├── setup-project.sh    # Main script (auto-downloads skills)
├── sync-skills.sh      # Optional: force refresh skills cache
└── skills/             # Auto-populated on first run (23 skills)
    ├── api-and-interface-design/
    ├── ci-cd-and-automation/
    ├── code-review-and-quality/
    ├── code-simplification/
    ├── context-engineering/
    ├── debugging-and-error-recovery/
    ├── deprecation-and-migration/
    ├── documentation-and-adrs/
    ├── doubt-driven-development/
    ├── frontend-ui-engineering/
    ├── git-workflow-and-versioning/
    ├── idea-refine/
    ├── incremental-implementation/
    ├── interview-me/
    ├── performance-optimization/
    ├── planning-and-task-breakdown/
    ├── security-and-hardening/
    ├── shipping-and-launch/
    ├── source-driven-development/
    ├── spec-driven-development/
    ├── test-driven-development/
    ├── using-agent-skills/
    └── wiki/
```

## Credits

- Skills: [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills)
- Superpowers: [obra/superpowers](https://github.com/obra/superpowers)
- Wiki pattern: [Karpathy's LLM Wiki](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f)

## Requirements

- bash
- python3 (for OpenCode global config)
- Git
