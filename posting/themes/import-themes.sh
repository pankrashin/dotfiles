#!/bin/bash
# Copy posting themes to posting themes directory
# because of course it needs to be some other directory
# outside of .config

set -euo pipefail

themes_dir=$(posting locate themes | grep -v "Themes directory:" | head -1 | xargs)

if [[ -z "$themes_dir" ]]; then
    echo "Error: Could not determine themes directory from 'posting locate themes'"
    exit 1
fi

mkdir -p "$themes_dir"

script_dir="$(cd "$(dirname "$0")" && pwd)"

echo "Copying themes from: $script_dir"
echo "Copying themes to:   $themes_dir"
echo ""

copied=0

for file in "$script_dir"/*.yaml; do
    [[ -f "$file" ]] || continue
    cp "$file" "$themes_dir/"
    echo "Copied: $(basename "$file")"
    ((copied++))
done

echo ""

if [[ $copied -eq 0 ]]; then
    echo "No .yaml theme files found to copy."
else
    echo "Done. Copied $copied theme(s)."
fi
