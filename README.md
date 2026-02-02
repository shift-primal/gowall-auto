# gowall-auto

Batch convert images to a single file extension and color scheme using [gowall](https://github.com/Achno/gowall)

## Requirements

- [gowall](https://github.com/Achno/gowall) installed and in PATH

## Usage

1. Put your images in `input/`
2. Run the script with a theme:
   ```bash
   ./run.sh -t <theme> [-f <format>]
   ```

   - `-t <theme>` - Color scheme to apply (required)
   - `-f <format>` - Output format: `png`, `jpg`, `webp` (default: `png`)
3. Find themed images in `output/`
4. Original images are moved to `originals/`

## Themes

```
arcdark         atomdark        cat-frappe      cat-latte
catppuccin      cyberpunk       dracula         everforest
github-light    gruvbox         kanagawa        material
melange-dark    melange-light   monokai         night-owl
nord            oceanic-next    onedark         palenight
rose-pine       shades-of-purple solarized      srcery
sunset-aurant   sunset-saffron  sunset-tangerine synthwave-84
tokyo-dark      tokyo-moon      tokyo-storm
```

Run `./run.sh -h` to see all themes.

## Examples

```bash
./run.sh -t dracula
./run.sh -t nord -f webp
```
