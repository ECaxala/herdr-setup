# My setup

## Keys
- Navigation mirrors my herdr CLI config (`~/.config/herdr/config.toml`), hjkl style:
  - `ctrl-h` / `ctrl-l`: previous / next tab
  - `ctrl-k` / `ctrl-j`: previous / next space
  - `ctrl-shift-k` / `ctrl-shift-j`: previous / next agent
  - `ctrl-alt-h/j/k/l`: move focus between panes (left/down/up/right)
- These take ctrl-h/j/k/l from the shell on purpose; keep it that way.
- Magnet (window manager) runs on this Mac. Its Control+Option shortcuts used to
  swallow `ctrl-alt-j/k`; I removed them from Magnet. Check Magnet first if a
  ctrl-alt key stops reaching Herdr.

## Layout
- I use `DEVandro` (my clone of `main`, formerly `my-main`) with `my-spaces` and `my-agents` (clones of
  `spaces`/`agents`). Only change: the narrow sidebar rail shows space avatars
  (colored letter tiles) and agent program icons instead of numbers.
- `cmd-b` toggles the sidebar between the rail (76 px) and its last width (via `my-agents.toggle-sidebar`).
- No Files/Changes side panel: removed from `DEVandro`, and shared `workspace.panels` is `[]` so the tab bar shows no buttons for them.

## Themes
- Each `themes/*.json` (except win98) sets `colors.chrome` to its palette's sidebar color
  (rose-pine `#1f1d2e`, catppuccin mantle, etc.) so the sidebar/bars follow the theme
  instead of Herdr's derived neutral. New theme files need their own `chrome`.
- `my-spaces` avatars use the theme's ANSI colors (not the shipped fixed `MARK` table),
  letter in theme background/foreground by contrast.
