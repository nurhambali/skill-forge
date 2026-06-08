#!/bin/bash
# Force refresh skills cache dari upstream
# Usage: bash /path/to/ai/sync-skills.sh

set -euo pipefail

SKILLS_DIR="$(dirname "$(realpath "$0")")/skills"

echo "=========================================="
echo "  Refreshing Skills Cache"
echo "=========================================="

# Remove existing skills
rm -rf "$SKILLS_DIR"

# Re-download
TMPDIR=$(mktemp -d)
trap 'rm -rf "$TMPDIR"' EXIT

echo ""
echo "[1/2] Cloning addyosmani/agent-skills..."
if ! git clone --depth 1 https://github.com/addyosmani/agent-skills.git "$TMPDIR/agent-skills" 2>/dev/null; then
    echo "[ERROR] Gagal clone addyosmani/agent-skills. Cek koneksi internet."
    exit 1
fi

echo "[2/2] Cloning obra/superpowers..."
if ! git clone --depth 1 https://github.com/obra/superpowers.git "$TMPDIR/superpowers" 2>/dev/null; then
    echo "[ERROR] Gagal clone obra/superpowers. Cek koneksi internet."
    exit 1
fi

echo ""
echo "Installing skills..."

mkdir -p "$SKILLS_DIR"

# Copy skills from addyosmani/agent-skills
if [ -d "$TMPDIR/agent-skills/skills" ]; then
    cp -r "$TMPDIR/agent-skills/skills"/* "$SKILLS_DIR/"
fi

# Copy wiki skill from obra/superpowers
if [ -d "$TMPDIR/superpowers/skills/wiki" ]; then
    cp -r "$TMPDIR/superpowers/skills/wiki" "$SKILLS_DIR/wiki"
fi

echo ""
echo "=========================================="
SKILL_COUNT=$(ls -1d "$SKILLS_DIR"/*/ 2>/dev/null | wc -l)
echo "Done! $SKILL_COUNT skills installed"
echo "=========================================="
