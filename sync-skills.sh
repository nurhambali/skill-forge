#!/bin/bash
# Sync skills dari recon-data ke /opt/ai/skills
# Jalankan ini kalau ada skill baru di recon-data
# Usage: bash /opt/ai/sync-skills.sh

set -e

SOURCE="/opt/recon-data/.opencode/skills"
TARGET="/opt/ai/skills"

echo "Syncing skills from $SOURCE to $TARGET..."

if [ ! -d "$SOURCE" ]; then
    echo "[ERROR] Source not found: $SOURCE"
    exit 1
fi

for skill_dir in "$SOURCE"/*/; do
    skill_name=$(basename "$skill_dir")
    if [ -d "$TARGET/$skill_name" ]; then
        echo "[UPDATE] $skill_name"
        rm -rf "$TARGET/$skill_name"
    else
        echo "[NEW] $skill_name"
    fi
    cp -r "$skill_dir" "$TARGET/$skill_name"
done

echo ""
echo "Done! $(ls -1d "$TARGET"/*/ | wc -l) skills synced"
