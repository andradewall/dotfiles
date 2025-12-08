#!/usr/bin/env bash
set -euo pipefail

OUT_DIR="${1:-dconf}"
mkdir -p "$OUT_DIR"

dump() {
  local path="$1" file="$2"
  echo "→ $file"
  dconf dump "$path" >"$OUT_DIR/$file"
}

# Window manager & workspace bindings
dump '/org/gnome/desktop/wm/keybindings/' 'wm-keybindings.dconf'
dump '/org/gnome/desktop/wm/preferences/' 'wm-preferences.dconf'

# Shell & Mutter (some global bindings live here)
dump '/org/gnome/shell/keybindings/' 'shell-keybindings.dconf'
dump '/org/gnome/mutter/' 'mutter.dconf'

# Media keys (volume, screenshots, etc.) + your custom entries
dump '/org/gnome/settings-daemon/plugins/media-keys/' 'media-keys.dconf'
dump '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/' 'media-keys-custom.dconf'

echo "Done. Files saved under: $OUT_DIR/"
