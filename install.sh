#!/bin/sh
# Install the DEVandro-light layout (or, with --full, the DEVandro cockpit),
# its mods and themes into a Herdr home.
# Run from a clone of this repo (not from ~/.config/herdr-app itself).
#
#   ./install.sh            copy the DEVandro-light layout, mods and themes; skip anything that exists
#   ./install.sh --full     also install the DEVandro cockpit layout and check for its extra mods (README, "Cockpit tools")
#   ./install.sh --keys     also install keys.json (existing one is backed up)
#   ./install.sh --dry-run  show what would happen, change nothing
#
# Local only: no network calls, nothing is ever overwritten except keys.json
# (and only with --keys, after a timestamped backup).

set -eu

SRC=$(cd "$(dirname "$0")" && pwd)
HOME_DIR=${HERDR_APP_HOME:-$HOME/.config/herdr-app}
LAYOUT=DEVandro-light
COCKPIT_MODS="gitview"
MODS="my-spaces my-agents"

FULL=0
KEYS=0
DRY=0
for arg in "$@"; do
  case $arg in
    --full) FULL=1; LAYOUT=DEVandro ;;
    --keys) KEYS=1 ;;
    --dry-run) DRY=1 ;;
    -h|--help) sed -n '2,12p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
    *) echo "unknown option: $arg" >&2; exit 2 ;;
  esac
done

if [ "$SRC" = "$(cd "$HOME_DIR" 2>/dev/null && pwd || true)" ]; then
  echo "This is already your Herdr home; clone the repo elsewhere first." >&2
  exit 1
fi
[ -d "$HOME_DIR" ] || { echo "Herdr home not found: $HOME_DIR (start Herdr once)." >&2; exit 1; }

run() { if [ "$DRY" = 1 ]; then echo "  would: $*"; else "$@"; fi; }

# copy_new <src> <dest>: copy a file or folder only if dest does not exist.
copy_new() {
  if [ -e "$2" ]; then
    echo "skip   $2 (exists)"
  else
    echo "copy   $2"
    run cp -R "$1" "$2"
  fi
}

echo "Installing into $HOME_DIR"
echo "Writes: layouts/$LAYOUT.json (+ DEVandro-light), mods/{$(echo $MODS | tr ' ' ,)}, themes/*.json"
[ "$KEYS" = 1 ] && echo "        keys.json (backed up first)"
echo

run mkdir -p "$HOME_DIR/layouts" "$HOME_DIR/mods" "$HOME_DIR/themes"

copy_new "$SRC/layouts/DEVandro-light.json" "$HOME_DIR/layouts/DEVandro-light.json"
[ "$FULL" = 1 ] && copy_new "$SRC/layouts/DEVandro.json" "$HOME_DIR/layouts/DEVandro.json"
for m in $MODS; do copy_new "$SRC/mods/$m" "$HOME_DIR/mods/$m"; done
for t in "$SRC"/themes/*.json; do copy_new "$t" "$HOME_DIR/themes/$(basename "$t")"; done

if [ "$KEYS" = 1 ]; then
  if [ -e "$HOME_DIR/keys.json" ]; then
    bak="$HOME_DIR/keys.json.bak-$(date +%Y%m%d-%H%M%S)"
    echo "backup $bak"
    run cp "$HOME_DIR/keys.json" "$bak"
  fi
  echo "copy   $HOME_DIR/keys.json"
  echo "note   ctrl-h/j/k/l now navigate tabs and spaces; the shell no longer gets them"
  run cp "$SRC/keys.json" "$HOME_DIR/keys.json"
fi

[ "$DRY" = 1 ] && { echo; echo "Dry run: nothing changed."; exit 0; }

if [ "$FULL" = 1 ]; then
  echo
  for m in $COCKPIT_MODS; do
    [ -d "$HOME_DIR/mods/$m" ] || echo "missing mods/$m: the cockpit panel stays empty until you add it (see the README)"
  done
fi

echo
if command -v herdr-app >/dev/null 2>&1; then
  for m in $MODS; do
    herdr-app check "$HOME_DIR/mods/$m" || { echo "check failed for $m; not switching layout." >&2; exit 1; }
  done
  herdr-app do layout.switch --name "$LAYOUT"
  echo "Done. Switch back with ctrl-shift-l; reset with ctrl-alt-shift-escape."
else
  echo "herdr-app not on PATH: copied only. Run the checks and layout.switch yourself."
fi
