# AI Setup — Universal LLM Project Bootstrap

One script to setup any project for any LLM tool with wiki + skills.

## Install

```bash
git clone https://github.com/youruser/ai-setup.git /opt/ai
bash /opt/ai/setup-project.sh --help
```

## Quick Start

```bash
# OpenCode (full support: skills + wiki)
bash /opt/ai/setup-project.sh --opencode /path/to/project "Project Name"

# Claude Code
bash /opt/ai/setup-project.sh --claude /path/to/project "Project Name"

# Kiro (AWS)
bash /opt/ai/setup-project.sh --kiro /path/to/project "Project Name"

# Cursor
bash /opt/ai/setup-project.sh --cursor /path/to/project "Project Name"

# Copilot
bash /opt/ai/setup-project.sh --copilot /path/to/project "Project Name"

# Windsurf (Codeium)
bash /opt/ai/setup-project.sh --windsurf /path/to/project "Project Name"

# Amp (Sourcegraph)
bash /opt/ai/setup-project.sh --amp /path/to/project "Project Name"

# Auto-detect
bash /opt/ai/setup-project.sh /path/to/project "Project Name"
```

## Supported Tools

| Tool | Flag | Config File | Skills | Wiki |
|------|------|-------------|--------|------|
| OpenCode | `--opencode` | `.opencode/AGENTS.md` | ✅ 12 skills | ✅ auto-update |
| Claude Code | `--claude` | `CLAUDE.md` | ❌ | ✅ via rules |
| GitHub Copilot | `--copilot` | `COPILOT.md` | ❌ | ✅ via rules |
| Cursor | `--cursor` | `.cursorrules` | ❌ | ✅ via rules |
| Kiro (AWS) | `--kiro` | `.kiro/rules.md` | ❌ | ✅ via rules |
| Windsurf | `--windsurf` | `.windsurfrules` | ❌ | ✅ via rules |
| Amp | `--amp` | `.amprc` | ❌ | ✅ via rules |

## What It Creates

```
project/
├── AGENTS.md                    # Universal config (all tools)
├── .opencode/                   # OpenCode only
│   ├── AGENTS.md
│   ├── opencode.json
│   └── skills/ (12 skills)
├── CLAUDE.md                    # Claude Code only
├── .cursorrules                 # Cursor only
├── .kiro/rules.md               # Kiro only
├── .windsurfrules               # Windsurf only
├── .amprc                       # Amp only
└── .wiki/                       # Universal (all tools)
    ├── index.md
    ├── log.md
    ├── architecture.md
    └── issues.md
```

## OpenCode Skills (12 included)

Skills sourced from [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) + custom wiki skill.

| Skill | Description | Source |
|-------|-------------|--------|
| [api-and-interface-design](https://github.com/addyosmani/agent-skills/tree/main/api-and-interface-design) | API design patterns | addyosmani/agent-skills |
| [ci-cd-and-automation](https://github.com/addyosmani/agent-skills/tree/main/ci-cd-and-automation) | CI/CD pipeline setup | addyosmani/agent-skills |
| [consistency-checker](https://github.com/addyosmani/agent-skills/tree/main/consistency-checker) | Code consistency | addyosmani/agent-skills |
| [context-engineering](https://github.com/addyosmani/agent-skills/tree/main/context-engineering) | Agent context optimization | addyosmani/agent-skills |
| [doubt-driven-development](https://github.com/addyosmani/agent-skills/tree/main/doubt-driven-development) | Verification before completion | addyosmani/agent-skills |
| [frontend-ui-engineering](https://github.com/addyosmani/agent-skills/tree/main/frontend-ui-engineering) | Production UI development | addyosmani/agent-skills |
| [git-workflow-and-versioning](https://github.com/addyosmani/agent-skills/tree/main/git-workflow-and-versioning) | Git practices | addyosmani/agent-skills |
| [issue-handler](https://github.com/addyosmani/agent-skills/tree/main/issue-handler) | Issue workflow | addyosmani/agent-skills |
| [security-and-hardening](https://github.com/addyosmani/agent-skills/tree/main/security-and-hardening) | Security review | addyosmani/agent-skills |
| [source-driven-development](https://github.com/addyosmani/agent-skills/tree/main/source-driven-development) | Documentation-based coding | addyosmani/agent-skills |
| [spec-driven-development](https://github.com/addyosmani/agent-skills/tree/main/spec-driven-development) | Spec-first development | addyosmani/agent-skills |
| [wiki](https://github.com/obra/superpowers) | LLM-maintained knowledge base | obra/superpowers |

### Superpowers Plugin

Skills powered by [obra/superpowers](https://github.com/obra/superpowers) — the OpenCode skill framework.

```json
// ~/.config/opencode/opencode.json
{
  "plugin": [
    "superpowers@git+https://github.com/obra/superpowers.git#v5.1.0"
  ]
}
```

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

## Sync Skills

When new skills are added upstream:

```bash
bash /opt/ai/sync-skills.sh
```

## Files

```
/opt/ai/
├── README.md
├── setup-project.sh    # Main script
├── sync-skills.sh      # Sync skills from upstream
└── skills/             # 12 OpenCode skills
    ├── api-and-interface-design/
    ├── ci-cd-and-automation/
    ├── consistency-checker/
    ├── context-engineering/
    ├── doubt-driven-development/
    ├── frontend-ui-engineering/
    ├── git-workflow-and-versioning/
    ├── issue-handler/
    ├── security-and-hardening/
    ├── source-driven-development/
    ├── spec-driven-development/
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
