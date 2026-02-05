#!/bin/bash
# Sync skills from this repo to ~/.claude/skills
# Does NOT delete existing skills that aren't in this repo

set -u
set -o pipefail
shopt -s nullglob

# Resolve script directory (handle symlinks)
SOURCE="${BASH_SOURCE[0]}"
while [[ -L "$SOURCE" ]]; do
    DIR="$(cd -P "$(dirname "$SOURCE")" && pwd)"
    SOURCE="$(readlink "$SOURCE")"
    [[ "$SOURCE" != /* ]] && SOURCE="$DIR/$SOURCE"
done
SCRIPT_DIR="$(cd -P "$(dirname "$SOURCE")" && pwd)"

TARGET_DIR="$HOME/.claude/skills"

# Counters for summary
synced=0
skipped=0
errors=0

# Create target directory if it doesn't exist
if ! mkdir -p "$TARGET_DIR" 2>/dev/null; then
    echo "ERROR: Cannot create target directory $TARGET_DIR"
    exit 1
fi

# Find and copy skill folders (folders containing SKILL.md)
for item in "$SCRIPT_DIR"/*/; do
    [[ ! -d "$item" ]] && continue

    skill_name=$(basename "$item")

    # Skip symlinked directories
    if [[ -L "${item%/}" ]]; then
        echo "SKIPPED: $skill_name (symlink)"
        ((skipped++))
        continue
    fi

    # Skip if not readable
    if [[ ! -r "$item" ]]; then
        echo "SKIPPED: $skill_name (not readable)"
        ((skipped++))
        continue
    fi

    # Skip if no SKILL.md
    if [[ ! -f "${item}SKILL.md" ]]; then
        continue  # Silently skip non-skill directories
    fi

    # Copy the skill (preserve permissions and timestamps)
    # Strip trailing slash to copy the directory itself, not just contents
    if cp -a "${item%/}" "$TARGET_DIR/" 2>/dev/null; then
        echo "SYNCED: $skill_name"
        ((synced++))
    else
        echo "ERROR: $skill_name (copy failed)"
        ((errors++))
    fi
done

# Summary
echo ""
echo "Summary: $synced synced, $skipped skipped, $errors errors"

# Exit code: 1 only if no skills synced AND there were errors
if [[ $synced -eq 0 && $errors -gt 0 ]]; then
    exit 1
fi
exit 0
