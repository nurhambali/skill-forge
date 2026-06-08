#!/bin/bash
# Universal Project Setup — All LLM Tools
# Usage: bash /path/to/ai/setup-project.sh [--opencode|--claude|--copilot|--cursor|--kiro|--antigravity] /path/to/project [name]
#
# Contoh:
#   bash /path/to/ai/setup-project.sh --opencode . "My App"
#   bash /path/to/ai/setup-project.sh --claude . "My App"
#   bash /path/to/ai/setup-project.sh --kiro . "My App"
#   bash /path/to/ai/setup-project.sh --antigravity . "My App"
#
# Install from GitHub:
#   git clone https://github.com/youruser/ai-setup.git /path/to/ai
#   bash /path/to/ai/setup-project.sh --opencode /path/to/project "Project Name"

set -euo pipefail

# Parse --tool flag
TOOL=""
POSITIONAL=()
for arg in "$@"; do
    case "$arg" in
        --opencode) TOOL="opencode" ;;
        --claude) TOOL="claude" ;;
        --copilot) TOOL="copilot" ;;
        --cursor) TOOL="cursor" ;;
        --kiro) TOOL="kiro" ;;

        --antigravity) TOOL="antigravity" ;;
        --help|-h)
            echo "Usage: bash /path/to/ai/setup-project.sh [--tool] /path/to/project [name]"
            echo ""
            echo "Tools:"
            echo "  --opencode    OpenCode (full: skills + wiki)"
            echo "  --claude      Claude Code"
            echo "  --copilot     GitHub Copilot CLI"
            echo "  --cursor      Cursor IDE"
            echo "  --kiro        Kiro (AWS)"

            echo "  --antigravity Antigravity AI"
            echo "  (none)        Auto-detect"
            exit 0
            ;;
        *) POSITIONAL+=("$arg") ;;
    esac
done

PROJECT_DIR="${POSITIONAL[0]:-.}"
PROJECT_NAME="${POSITIONAL[1]:-$(basename "$(realpath "$PROJECT_DIR")")}"
SKILLS_SOURCE="$(dirname "$(realpath "$0")")/skills"

# Function to download skills from upstream
download_skills() {
    local tmpdir
    tmpdir=$(mktemp -d) || { echo "[ERROR] Gagal buat temp directory"; return 1; }
    echo "[DOWNLOAD] Fetching skills from upstream..."
    
    local clone_ok=0
    
    echo "[1/2] Cloning addyosmani/agent-skills..."
    if git clone --depth 1 https://github.com/addyosmani/agent-skills.git "$tmpdir/agent-skills" 2>/dev/null; then
        clone_ok=1
    else
        echo "[WARN] Gagal clone addyosmani/agent-skills. Cek koneksi internet."
    fi
    
    echo "[2/2] Cloning obra/superpowers..."
    if git clone --depth 1 https://github.com/obra/superpowers.git "$tmpdir/superpowers" 2>/dev/null; then
        clone_ok=1
    else
        echo "[WARN] Gagal clone obra/superpowers. Cek koneksi internet."
    fi
    
    if [ "$clone_ok" -eq 0 ]; then
        echo "[ERROR] Tidak ada skills yang berhasil di-download. Periksa koneksi internet."
        rm -rf "$tmpdir"
        return 1
    fi
    
    # Create skills directory
    mkdir -p "$SKILLS_SOURCE"
    rm -rf "${SKILLS_SOURCE:?}"/*
    
    # Copy skills from addyosmani/agent-skills
    if [ -d "$tmpdir/agent-skills/skills" ]; then
        cp -r "$tmpdir/agent-skills/skills"/* "$SKILLS_SOURCE/"
    fi
    
    # Copy wiki skill from obra/superpowers
    if [ -d "$tmpdir/superpowers/skills/wiki" ]; then
        cp -r "$tmpdir/superpowers/skills/wiki" "$SKILLS_SOURCE/wiki"
    fi
    
    # Cleanup
    rm -rf "$tmpdir"
    
    local skill_count
    skill_count=$(ls -1d "$SKILLS_SOURCE"/*/ 2>/dev/null | wc -l)
    echo "[OK] Downloaded $skill_count skills"
}

# Check if skills exist, if not download them
if [ ! -d "$SKILLS_SOURCE" ] || [ -z "$(ls -A "$SKILLS_SOURCE" 2>/dev/null)" ]; then
    download_skills
fi

# Auto-detect if no flag
if [ -z "$TOOL" ]; then
    if [ -d "$PROJECT_DIR/.opencode" ] || command -v opencode &>/dev/null; then
        TOOL="opencode"
    elif [ -f "$HOME/.claude/settings.json" ] || command -v claude &>/dev/null; then
        TOOL="claude"
    elif command -v copilot &>/dev/null; then
        TOOL="copilot"
    elif [ -d "$HOME/.cursor" ]; then
        TOOL="cursor"
    elif [ -d "$HOME/.kiro" ] || command -v kiro &>/dev/null; then
        TOOL="kiro"
    elif [ -d "$HOME/.antigravity" ] || command -v antigravity &>/dev/null; then
        TOOL="antigravity"
    else
        TOOL="opencode"
    fi
fi

echo "=========================================="
echo "  Universal Project Setup"
echo "=========================================="
echo "  Project: $PROJECT_NAME"
echo "  Dir:     $PROJECT_DIR"
echo "  Tool:    $TOOL"
echo "=========================================="

mkdir -p "$PROJECT_DIR/.wiki"

# =============================================
# 1. Universal AGENTS.md
# =============================================
cat > "$PROJECT_DIR/AGENTS.md" << 'EOF'
# AGENTS.md — Project Config

## Quick Start

1. Read project config below
2. Read `.wiki/index.md` — architecture, decisions, results

## Git Workflow

- `main` = production, `dev` = staging
- NEVER push langsung ke `main`
- Semua perubahan push ke `dev` dulu

## Wiki — WAJIB AUTO-UPDATE

Project wiki at `.wiki/` — persistent memory antar session.

**RULES (WAJIB DI IKUTI):**
1. **Sesi baru** → baca `.wiki/index.md` dulu sebelum jawab apa-apa
2. **Setelah code change** → update `.wiki/log.md` dengan entry baru
3. **Setelah optimasi/benchmark** → update `.wiki/architecture.md` + `AGENTS.md` Current State
4. **Setelah fix bug** → tambahin ke `.wiki/issues.md`
5. **Commit** → pastikan `.wiki/` juga di-commit

**Wiki Files:**
- `.wiki/index.md` — navigation (update kalau tambah page)
- `.wiki/log.md` — changelog (append setiap ada perubahan)
- `.wiki/architecture.md` — system design + benchmark results
- `.wiki/issues.md` — known issues + solutions

## Skill Table

| Kondisi | Skill |
|---------|-------|
| Sesi baru / greeting | `wiki` |
| Edit frontend | `frontend-ui-engineering` |
| Tambah endpoint | `api-and-interface-design` |
| Auth / security | `security-and-hardening` |
| CI/CD / Docker | `ci-cd-and-automation` |
| Fitur baru | `spec-driven-development` |
| Critical logic | `doubt-driven-development` |
| Framework code | `source-driven-development` |
| Commit / branch | `git-workflow-and-versioning` |
| GitLab issue | `issue-handler` |
| Code consistency | `consistency-checker` |
| Update docs | `wiki` |
EOF

# =============================================
# 2. Universal skills copy (all tools)
# =============================================
mkdir -p "$PROJECT_DIR/.opencode/skills"
SKILL_COUNT=0
if [ -d "$SKILLS_SOURCE" ]; then
    for skill_dir in "$SKILLS_SOURCE"/*/; do
        skill_name=$(basename "$skill_dir")
        cp -r "$skill_dir" "$PROJECT_DIR/.opencode/skills/$skill_name"
        SKILL_COUNT=$((SKILL_COUNT + 1))
        echo "[OK] Skill: $skill_name"
    done
fi

# Generate built-in output-mode skill (cave)
mkdir -p "$PROJECT_DIR/.opencode/skills/output-mode"
cat > "$PROJECT_DIR/.opencode/skills/output-mode/SKILL.md" << 'EOF'
---
name: output-mode
description: Atur verbosity AI. Panggil dengan "/cave <level>". Hemat token tanpa turunin kualitas.
---

# Output Mode

Gunakan skill ini ketika user minta ngubah cara AI ngomong — lebih hemat token atau lebih detail.

## Level

| Perintah | Efek | Hemat Token |
|----------|------|:-----------:|
| `cave normal` | Reasoning Framework 5 langkah full (default) | 0% |
| `cave ringkas` | 5 langkah, 1 kalimat per langkah | ~40% |
| `cave ultra` | Langsung masalah → solusi, tanpa analisis/konteks | ~65% |
| `cave caveman` | Fragment aja. No kalimat panjang. Brain still big. | ~75% |

## Cara Pakai

User: "cave ringkas" atau "/cave ultra"
Mode berlaku sampai sesi berakhir atau diubah lagi.

## Catatan

- Mode cuma ngaruh ke cara nulis — kualitas kode tetap sama
- Kalau ragu, balik ke "cave normal"
EOF
SKILL_COUNT=$((SKILL_COUNT + 1))
echo "[OK] Skill: output-mode (cave)"

# =============================================
# 3. Universal SKILL_LOADER.md (all tools)
# =============================================
cat > "$PROJECT_DIR/SKILL_LOADER.md" << 'EOF'
# SKILL_LOADER.md — Universal Skill Loader

Semua AI tools (OpenCode, Claude, Copilot, Cursor, Kiro, Antigravity)
berbagi sumber skill yang sama di `.opencode/skills/`.

## ⚠️ WAJIB: Reasoning Framework

Sebelum menjawab atau mengimplementasi apapun, tulis response dengan format berikut.
JANGAN PERNAH SKIP LANGKAH INI — ini yang membedakan hasil kerja terstruktur dan asal-asalan.

### 1. ANALISIS
Apa yang diminta user? Breakdown masalahnya dalam 1-2 kalimat.
Contoh: "User minta fitur search dengan filter kategori. Ini berarti butuh endpoint API + UI komponen + database query."

### 2. KONTEKS
Framework/arsitektur/constraint yang relevan.
Baca `.wiki/index.md` dan file project yang terkait.

### 3. RENCANA
Langkah-langkah solusi sebelum menulis kode. Minimal 3 langkah konkret.
Contoh: "1. Buat migration table products 2. Buat API route GET /products 3. Buat komponen SearchBar 4. Integrasi dengan API"

### 4. EKSEKUSI
Implementasi sesuai rencana.

### 5. VERIFIKASI
Cek ulang apakah solusi sudah sesuai requirement.
**Kalau ragu, tulis "Saya ragu karena ..." dan jangan lanjut sebelum jelas.**

---

## Cara Load Skill

1. Pahami konteks/user request
2. Cari skill yang relevan dari tabel di bawah
3. Baca file `.opencode/skills/<nama>/SKILL.md`
4. Ikuti instruksi di skill tersebut

## Skill Index

| Kondisi | Skill | File |
|---------|-------|------|
| Sesi baru / greeting | wiki | `.opencode/skills/wiki/SKILL.md` |
| Edit frontend | frontend-ui-engineering | `.opencode/skills/frontend-ui-engineering/SKILL.md` |
| Tambah endpoint / API | api-and-interface-design | `.opencode/skills/api-and-interface-design/SKILL.md` |
| Auth / security | security-and-hardening | `.opencode/skills/security-and-hardening/SKILL.md` |
| CI/CD / Docker | ci-cd-and-automation | `.opencode/skills/ci-cd-and-automation/SKILL.md` |
| Fitur baru | spec-driven-development | `.opencode/skills/spec-driven-development/SKILL.md` |
| Implementasi kode | incremental-implementation | `.opencode/skills/incremental-implementation/SKILL.md` |
| Critical / unfamiliar code | doubt-driven-development | `.opencode/skills/doubt-driven-development/SKILL.md` |
| Code review | code-review-and-quality | `.opencode/skills/code-review-and-quality/SKILL.md` |
| Debugging | debugging-and-error-recovery | `.opencode/skills/debugging-and-error-recovery/SKILL.md` |
| Performance | performance-optimization | `.opencode/skills/performance-optimization/SKILL.md` |
| Testing | test-driven-development | `.opencode/skills/test-driven-development/SKILL.md` |
| Planning | planning-and-task-breakdown | `.opencode/skills/planning-and-task-breakdown/SKILL.md` |
| Commit / branch | git-workflow-and-versioning | `.opencode/skills/git-workflow-and-versioning/SKILL.md` |
| Dokumentasi | documentation-and-adrs | `.opencode/skills/documentation-and-adrs/SKILL.md` |
| Atur hemat token | output-mode | `.opencode/skills/output-mode/SKILL.md` |

## Aturan

- Load skill HANYA jika relevan — jangan load semua
- Update `.wiki/log.md` setelah ada perubahan
EOF

# =============================================
# 4. Tool-specific setup
# =============================================
case "$TOOL" in
    opencode)
        echo "[OPENCODE] Setting up..."
        
        cat > "$PROJECT_DIR/.opencode/AGENTS.md" << 'EOF'
<CRITICAL_DIRECTIVE>
ATTENTION AGENT: You are operating under the `using-superpowers` flow.
When the user says "halo", "hai", or ANY greeting:
1. You MUST answer "YES" to "Might any skill apply?".
2. The task is "Initialize Workspace Context".
3. The REQUIRED skill is `wiki`.
4. Therefore, you MUST invoke `skill({name: "wiki"})` BEFORE your first text response.
DO NOT short-circuit this step.
</CRITICAL_DIRECTIVE>

# Project Context

<!-- Isi nama + deskripsi project -->

## Current State

<!-- Isi status terkini: sedang kerja apa, bottleneck, target -->

## ABSOLUTE RULES

1. **SETIAP user message → load skill dulu.**
2. **WAJIB baca `.wiki/index.md` di sesi baru.**
3. **WAJIB update "Current State" setelah optimasi/benchmark.**
4. Git: push ke `dev`, MR ke `main`.

### Skill Load Table

| Kondisi | skill `name` |
|---------|------|
| Sesi baru | `wiki` |
| Edit frontend | `frontend-ui-engineering` |
| Tambah endpoint | `api-and-interface-design` |
| Auth / security | `security-and-hardening` |
| CI/CD / Docker | `ci-cd-and-automation` |
| Fitur baru | `spec-driven-development` |
| Critical logic | `doubt-driven-development` |
| Framework code | `source-driven-development` |
| Commit / branch | `git-workflow-and-versioning` |
| GitLab issue | `issue-handler` |
| Code consistency | `consistency-checker` |
| Update docs | `wiki` |

## Struktur

<!-- Isi struktur project -->

## Coding Conventions

<!-- Isi conventions -->

## Active Plans

<!-- Isi plan aktif -->
EOF
        
        cat > "$PROJECT_DIR/.opencode/opencode.json" << 'EOF'
{
  "$schema": "https://opencode.ai/config.json",
  "instructions": ["AGENTS.md"]
}
EOF
        
        cat > "$PROJECT_DIR/.opencode/package.json" << 'EOF'
{
  "dependencies": {
    "@opencode-ai/plugin": "1.14.48"
  }
}
EOF
        
        cat > "$PROJECT_DIR/.opencode/.gitignore" << 'EOF'
node_modules/
package-lock.json
*.log
EOF
        
        # Install superpowers plugin
        GLOBAL_CONFIG="$HOME/.config/opencode/opencode.json"
        if [ -f "$GLOBAL_CONFIG" ]; then
            if ! grep -q "superpowers" "$GLOBAL_CONFIG" 2>/dev/null; then
                cp "$GLOBAL_CONFIG" "$GLOBAL_CONFIG.bak"
                python3 -c "
import json
with open('$GLOBAL_CONFIG', 'r') as f:
    config = json.load(f)
plugins = config.get('plugin', [])
plugins.append('superpowers@git+https://github.com/obra/superpowers.git')
config['plugin'] = plugins
with open('$GLOBAL_CONFIG', 'w') as f:
    json.dump(config, f, indent=2)
" 2>/dev/null && echo "[OK] Superpowers plugin added" || echo "[WARN] Could not update global config"
            fi
        fi
        ;;
    
    claude)
        echo "[CLAUDE] Setting up..."
        mkdir -p "$PROJECT_DIR/.claude"
        cat > "$PROJECT_DIR/CLAUDE.md" << 'EOF'
# CLAUDE.md — Project Config

## Quick Start
1. Baca `SKILL_LOADER.md` — cara load skill yang relevan
2. Baca `.wiki/index.md` — arsitektur dan keputusan
3. Update `.wiki/` setelah setiap perubahan

## Git Workflow
- `main` = production, `dev` = staging
- Jangan push langsung ke `main`

## Conventions
<!-- Isi conventions project disini -->
EOF
        cat > "$PROJECT_DIR/.claude/settings.json" << 'EOF'
{
  "permissions": {
    "allow": [],
    "deny": []
  }
}
EOF
        ;;
    
    copilot)
        echo "[COPILOT] Setting up..."
        mkdir -p "$PROJECT_DIR/.github"
        cat > "$PROJECT_DIR/COPILOT.md" << 'EOF'
# COPILOT.md — Project Config

Baca `SKILL_LOADER.md` untuk cara load skill.
Baca `.wiki/index.md` untuk arsitektur.
EOF
        ;;
    
    cursor)
        echo "[CURSOR] Setting up..."
        mkdir -p "$PROJECT_DIR/.cursor"
        cat > "$PROJECT_DIR/.cursorrules" << 'EOF'
# Cursor Rules

## Project Context

Baca `SKILL_LOADER.md` untuk cara load skill.
Baca `.wiki/index.md` untuk arsitektur.
EOF
        cat > "$PROJECT_DIR/.cursor/settings.json" << 'EOF'
{
  "ai.enableCodebaseIndexing": true,
  "ai.useContextFiles": true
}
EOF
        ;;
    
    kiro)
        echo "[KIRO] Setting up..."
        mkdir -p "$PROJECT_DIR/.kiro"
        cat > "$PROJECT_DIR/.kiro/rules.md" << 'EOF'
# Kiro Rules

## Project Context

Baca `SKILL_LOADER.md` untuk cara load skill.
Baca `.wiki/index.md` untuk arsitektur.
EOF
        cat > "$PROJECT_DIR/.kiro/settings.json" << 'EOF'
{
  "ai": {
    "model": "default",
    "contextFiles": [".wiki/index.md"]
  }
}
EOF
        ;;
    
    antigravity)
        echo "[ANTIGRAVITY] Setting up..."
        mkdir -p "$PROJECT_DIR/.antigravity"
        cat > "$PROJECT_DIR/.antigravity/rules.md" << 'EOF'
# Antigravity Rules

Baca `SKILL_LOADER.md` untuk cara load skill.
Baca `.wiki/index.md` untuk arsitektur.
EOF
        ;;

    *)
        echo "[ERROR] Unknown tool: $TOOL"
        echo "Supported: --opencode, --claude, --copilot, --cursor, --kiro, --antigravity"
        exit 1
        ;;
esac

# =============================================
# 5. Wiki files (UNIVERSAL)
# =============================================
TODAY=$(date +%Y-%m-%d)

cat > "$PROJECT_DIR/.wiki/index.md" << EOF
# Wiki Index

## Architecture
- [System Architecture](architecture.md)

## Issues
- [Known Issues](issues.md)

---

*Last updated: $TODAY*
EOF

cat > "$PROJECT_DIR/.wiki/log.md" << EOF
# Wiki Log

## $TODAY — Initial Setup

- Wiki initialized
- Tool: $TOOL

---

*Append new entries at the top.*
EOF

cat > "$PROJECT_DIR/.wiki/architecture.md" << 'EOF'
# System Architecture

## Overview

<!-- Isi overview -->

## Data Flow

<!-- Isi data flow -->

## Key Components

<!-- Isi komponen -->

## Benchmark Results

<!-- Isi benchmark -->

---

*Update when architecture changes.*
EOF

cat > "$PROJECT_DIR/.wiki/issues.md" << 'EOF'
# Known Issues

<!-- Tambahkan issues -->

---

*Append at the top.*
EOF

# =============================================
# SUMMARY
# =============================================
echo ""
echo "=========================================="
echo "  Setup Complete!"
echo "=========================================="
echo ""
echo "  Tool: $TOOL"
echo ""
echo "  Files created:"
echo "    - AGENTS.md (universal config)"
echo "    - SKILL_LOADER.md (universal skill loader)"
echo "    - .opencode/skills/ (${SKILL_COUNT:-0} skills)"
case "$TOOL" in
    opencode)
        echo "    - .opencode/AGENTS.md"
        echo "    - .opencode/opencode.json"
        ;;
    claude) echo "    - CLAUDE.md" ;;
    copilot) echo "    - COPILOT.md" ;;
    cursor) echo "    - .cursorrules" ;;
    kiro) echo "    - .kiro/rules.md" ;;
    antigravity) echo "    - .antigravity/rules.md" ;;
esac
echo "    - .wiki/ (4 files)"
echo ""
echo "  Next: Edit AGENTS.md + .wiki/architecture.md"
echo ""
