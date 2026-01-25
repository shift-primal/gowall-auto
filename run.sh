#!/bin/bash

INPUT_DIR="./src/input"
OUTPUT_DIR="./src/output"
TEMP_DIR="./src/processing"

mkdir -p "$INPUT_DIR"
mkdir -p "$TEMP_DIR"
mkdir -p "$OUTPUT_DIR"

for pic in "$INPUT_DIR"/*; do
  [[ -e "$pic" ]] || continue
  filename=$(basename "$pic")
  new_location="$TEMP_DIR/$filename"

  echo "Moving $pic to temp folder..."
  mv "$pic" "$TEMP_DIR"
done

# move all images to another folder (./processing/)
# convert all images to png
# move all originals to another folder (./processed/)
# convert all images to colorscheme
# move all completed to ./output/
# delete all temporary photos
