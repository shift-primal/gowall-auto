#!/bin/bash

set -e

INPUT_DIR="./input"
OUTPUT_DIR="./output"
ORIGINALS_DIR="./originals"

VALID_THEMES=(
  "arcdark" "atomdark" "cat-frappe" "cat-latte" "catppuccin" "cyberpunk"
  "dracula" "everforest" "github-light" "gruvbox" "kanagawa" "material"
  "melange-dark" "melange-light" "monokai" "night-owl" "nord" "oceanic-next"
  "onedark" "palenight" "rose-pine" "shades-of-purple" "solarized" "srcery"
  "sunset-aurant" "sunset-saffron" "sunset-tangerine" "synthwave-84"
  "tokyo-dark" "tokyo-moon" "tokyo-storm"
)

usage() {
  echo "Usage: $0 -t <theme> [-f <format>]"
  echo ""
  echo "Options:"
  echo "  -t <theme>   Color scheme to apply (required)"
  echo "  -f <format>  Output format: png, jpg, webp (default: png)"
  echo ""
  echo "Valid themes:"
  printf '  %s\n' "${VALID_THEMES[@]}"
  exit 1
}

validate_theme() {
  local theme="$1"
  for valid in "${VALID_THEMES[@]}"; do
    if [[ "$valid" == "$theme" ]]; then
      return 0
    fi
  done
  return 1
}

THEME=""
FORMAT="png"
while getopts "t:f:h" opt; do
  case $opt in
  t) THEME="$OPTARG" ;;
  f) FORMAT="$OPTARG" ;;
  h) usage ;;
  *) usage ;;
  esac
done

if [[ ! "$FORMAT" =~ ^(png|jpg|jpeg|webp)$ ]]; then
  echo "Error: Invalid format '$FORMAT'. Use png, jpg, or webp."
  exit 1
fi

if [[ -z "$THEME" ]]; then
  echo "Error: Theme is required"
  usage
fi

if ! validate_theme "$THEME"; then
  echo "Error: Invalid theme '$THEME'"
  echo ""
  echo "Valid themes:"
  printf '  %s\n' "${VALID_THEMES[@]}"
  exit 1
fi

if [[ ! -d "$INPUT_DIR" ]] || [[ -z "$(ls -A "$INPUT_DIR" 2>/dev/null)" ]]; then
  echo "Error: No files found in $INPUT_DIR"
  exit 1
fi

mkdir -p "$OUTPUT_DIR"
mkdir -p "$ORIGINALS_DIR"

echo "==> Processing images with theme '$THEME' (format: $FORMAT)..."
for pic in "$INPUT_DIR"/*; do
  [[ -e "$pic" ]] || continue
  filename=$(basename "$pic")
  name="${filename%.*}"
  output_file="$OUTPUT_DIR/$name.$FORMAT"

  echo "  Processing: $filename -> $name.$FORMAT"
  gowall convert "$pic" --format "$FORMAT" --theme "$THEME" --output "$output_file"

  mv "$pic" "$ORIGINALS_DIR/"
done

echo ""
echo "Done!"
echo "  Themed images: $OUTPUT_DIR"
echo "  Originals moved to: $ORIGINALS_DIR"
