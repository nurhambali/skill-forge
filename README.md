# Skill Forge — Universal LLM Project Bootstrap

One script + one `forge` command to setup any project for any LLM tool with skills, reasoning framework, and wiki.

## Install

```bash
git clone https://github.com/nurhambali/skill-forge.git ~/skill-forge
cd ~/skill-forge && chmod +x setup-project.sh
```

### Global CLI (recommended)

```bash
# ~/.local/bin udah ada di PATH secara default di macOS/Linux
mkdir -p ~/.local/bin
ln -s ~/skill-forge/setup-project.sh ~/.local/bin/forge
```

Tinggal:

```bash
forge --opencode . "Project Name"
```

## Quick Start

```bash
forge --opencode .                    # OpenCode (skills sebagai file terpisah)
forge --claude .                      # Claude Code
forge --kiro .                        # Kiro (AWS)
forge --cursor .                      # Cursor
forge --copilot .                     # GitHub Copilot
forge --antigravity .                 # Antigravity
forge .                              # Auto-detect tool
forge --help                         # Bantuan
```

## Supported Tools

Semua tool pake sumber skill yang **sama** — `.opencode/skills/`.

| Tool | Flag | Config File | Skills |
|------|------|-------------|--------|
| OpenCode | `--opencode` | `.opencode/AGENTS.md` | ✅ file terpisah + superpowers plugin |
| Claude Code | `--claude` | `CLAUDE.md` | ✅ refer ke `.opencode/skills/` |
| GitHub Copilot | `--copilot` | `COPILOT.md` | ✅ refer ke `.opencode/skills/` |
| Cursor | `--cursor` | `.cursorrules` | ✅ refer ke `.opencode/skills/` |
| Kiro (AWS) | `--kiro` | `.kiro/rules.md` | ✅ refer ke `.opencode/skills/` |
| Antigravity | `--antigravity` | `.antigravity/rules.md` | ✅ refer ke `.opencode/skills/` |

## Output Structure

```
project/
├── AGENTS.md                    # Universal config (skill mapping table)
├── SKILL_LOADER.md              # ★ Universal entry point: reasoning framework + skill index
├── .opencode/
│   ├── AGENTS.md                # OpenCode-specific (superpowers flow)
│   ├── opencode.json
│   └── skills/ (24 skills)      # SEMUA tool pake ini
│       ├── output-mode/SKILL.md  # ★ Built-in: atur hemat token via "/cave"
│       ├── wiki/SKILL.md
│       └── ... (24 total)
├── CLAUDE.md                    # Kecil (~50 token, refer ke SKILL_LOADER.md)
├── COPILOT.md                   # Kecil
├── .cursorrules                 # Kecil
├── .kiro/rules.md               # Kecil
├── .antigravity/rules.md        # Kecil
└── .wiki/                       # Universal persistent memory
    ├── index.md
    ├── log.md
    ├── architecture.md
    └── issues.md
```

## Skills (24 included)

23 skills dari [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) + 1 built-in `output-mode`.

| Skill | Deskripsi | Source |
|-------|-----------|--------|
| api-and-interface-design | API design patterns | addyosmani/agent-skills |
| browser-testing-with-devtools | Browser testing | addyosmani/agent-skills |
| ci-cd-and-automation | CI/CD pipeline setup | addyosmani/agent-skills |
| code-review-and-quality | Code review best practices | addyosmani/agent-skills |
| code-simplification | Code simplification | addyosmani/agent-skills |
| context-engineering | Agent context optimization | addyosmani/agent-skills |
| debugging-and-error-recovery | Debugging workflows | addyosmani/agent-skills |
| deprecation-and-migration | Deprecation patterns | addyosmani/agent-skills |
| documentation-and-adrs | Documentation & ADRs | addyosmani/agent-skills |
| doubt-driven-development | Verification before completion | addyosmani/agent-skills |
| frontend-ui-engineering | Production UI development | addyosmani/agent-skills |
| git-workflow-and-versioning | Git practices | addyosmani/agent-skills |
| idea-refine | Idea refinement | addyosmani/agent-skills |
| incremental-implementation | Incremental implementation | addyosmani/agent-skills |
| interview-me | User interview | addyosmani/agent-skills |
| **output-mode** | **Atur verbosity AI via `/cave` (built-in)** | **skill-forge** |
| performance-optimization | Performance optimization | addyosmani/agent-skills |
| planning-and-task-breakdown | Task planning | addyosmani/agent-skills |
| security-and-hardening | Security review | addyosmani/agent-skills |
| shipping-and-launch | Shipping & launch | addyosmani/agent-skills |
| source-driven-development | Documentation-based coding | addyosmani/agent-skills |
| spec-driven-development | Spec-first development | addyosmani/agent-skills |
| test-driven-development | TDD workflows | addyosmani/agent-skills |
| using-agent-skills | Meta: how to use skills | addyosmani/agent-skills |
| wiki | LLM-maintained knowledge base | obra/superpowers |

## ⚠️ Reasoning Framework

`SKILL_LOADER.md` berisi **Reasoning Framework 5 langkah** yang WAJIB AI ikuti SEBELUM menjawab. Ini yang bikin AI murah (Haiku, 4o-mini) berpikir terstruktur seperti AI mahal.

```markdown
### 1. ANALISIS — breakdown masalah
### 2. KONTEKS — arsitektur & constraint project
### 3. RENCANA — minimal 3 langkah konkret
### 4. EKSEKUSI — implementasi sesuai rencana
### 5. VERIFIKASI — cek ulang + "Saya ragu karena..."
```

## Output Mode: `/cave` — Ganti Caveman

Built-in skill `output-mode` biar user atur verbosity AI langsung dari chat.

```markdown
User:  "cave ringkas"   → hemat ~40%, 1 kalimat per langkah
       "cave ultra"     → hemat ~65%, langsung masalah → solusi
       "cave caveman"   → hemat ~75%, fragment aja
       "cave normal"    → balik ke default (reasoning full)
```

## How Wiki Works

The wiki (`.wiki/`) adalah persistent memory system untuk LLM agents:

| File | Purpose | Updated When |
|------|---------|--------------|
| `.wiki/index.md` | Navigation catalog | Pages added/removed |
| `.wiki/log.md` | Chronological changelog | Every code change |
| `.wiki/architecture.md` | System design + benchmarks | Architecture changes |
| `.wiki/issues.md` | Known issues + solutions | Bugs found/fixed |

## Refresh Skills Cache

```bash
bash ~/skill-forge/sync-skills.sh
```

## CI

- **ShellCheck** — lint otomatis `.sh` files tiap push
- **BATS** — test coverage untuk semua tool flags

## Credits

- Skills: [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills)
- Superpowers: [obra/superpowers](https://github.com/obra/superpowers)
- Wiki pattern: [Karpathy's LLM Wiki](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f)

## Requirements

- bash
- python3 (for OpenCode global config)
- Git
