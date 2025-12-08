#!/usr/bin/env bash
set -euo pipefail

IN_DIR="${1:-dconf}"
BACKUP_DIR="${2:-backup-$(date +%Y%m%d-%H%M%S)}"
mkdir -p "$BACKUP_DIR"

bak() {
  local path="$1" file="$2"
  echo "↳ backup $file"
  dconf dump "$path" >"$BACKUP_DIR/$file"
}
load() {
  local path="$1" file="$2"
  echo "← load $file"
  dconf load "$path" <"$IN_DIR/$file"
}

echo "Backing up current GNOME bindings to $BACKUP_DIR/ ..."
bak '/org/gnome/desktop/wm/keybindings/' 'wm-keybindings.dconf'
bak '/org/gnome/desktop/wm/preferences/' 'wm-preferences.dconf'
bak '/org/gnome/shell/keybindings/' 'shell-keybindings.dconf'
bak '/org/gnome/mutter/' 'mutter.dconf'
bak '/org/gnome/settings-daemon/plugins/media-keys/' 'media-keys.dconf'
bak '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/' 'media-keys-custom.dconf'

echo "Importing saved bindings from $IN_DIR/ ..."
# Import custom subkeys first, then the parent list (order just to be tidy)
load '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/' 'media-keys-custom.dconf'
load '/org/gnome/settings-daemon/plugins/media-keys/' 'media-keys.dconf'
load '/org/gnome/desktop/wm/keybindings/' 'wm-keybindings.dconf'
load '/org/gnome/desktop/wm/preferences/' 'wm-preferences.dconf'
load '/org/gnome/shell/keybindings/' 'shell-keybindings.dconf'
load '/org/gnome/mutter/' 'mutter.dconf'

echo "All set. You may need to log out/in for some bindings to take effect."
