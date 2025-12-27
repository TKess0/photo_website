#!/usr/bin/env bash
set -euo pipefail

SRC_DIR="image_sources"
DST_DIR="content/posts"

shopt -s nullglob

for project in "$SRC_DIR"/*; do
  [ -d "$project" ] || continue

  date=$(basename "$project")
  out="$DST_DIR/$date"

  mkdir -p "$out"

  for img in "$project"/*.jpg "$project"/*.jpeg; do
    base=$(basename "$img")
    name="${base%.*}"

    echo "Converting $img → $out/$name.webp"

    magick "$img" \
      -resize 2000x \
      -quality 85 \
      -strip \
      "$out/$name.webp"
  done
done
