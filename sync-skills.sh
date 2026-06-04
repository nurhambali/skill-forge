#!/bin/bash
# Force refresh skills cache dari upstream
# Opsional: script otomatis download kalau skills kosong
# Usage: bash /opt/ai/sync-skills.sh

set -e

SKILLS_DIR="$(dirname "$(realpath "$0")")/skills"

echo "=========================================="
echo "  Refreshing Skills Cache"
echo "=========================================="

# Remove existing skills
rm -rf "$SKILLS_DIR"

# Re-download
TMPDIR=$(mktemp -d)

echo ""
echo "[1/2] Cloning addyosmani/agent-skills..."
git clone --depth 1 https://github.com/addyosmani/agent-skills.git "$TMPDIR/agent-skills" 2>/dev/null

echo "[2/2] Cloning obra/superpowers..."
git clone --depth 1 https://github.com/obra/superpowers.git "$TMPDIR/superpowers" 2>/dev/null

echo ""
echo "Installing skills..."

mkdir -p "$SKILLS_DIR"

# Copy skills from addyosmani/agent-skills
if [ -d "$TMPDIR/agent-skills/skills" ]; then
    cp -r "$TMPDIR/agent-skills/skills"/* "$SKILLS_DIR/" 2>/dev/null
fi

# Copy wiki skill from obra/superpowers
if [ -d "$TMPDIR/superpowers/skills/wiki" ]; then
    cp -r "$TMPDIR/superpowers/skills/wiki" "$SKILLS_DIR/wiki"
fi

# Cleanup
rm -rf "$TMPDIR"

echo ""
echo "=========================================="
echo "Done! $(ls -1d "$SKILLS_DIR"/*/ 2>/dev/null | wc -l) skills installed"
echo "=========================================="
