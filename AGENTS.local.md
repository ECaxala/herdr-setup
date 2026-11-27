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
- Two layouts: `DEVandro` is the full cockpit (base plus a hidden right-hand `gitview` panel); `DEVandro-light` is the base without it and needs no extra mods. Cockpit mods are installed separately and listed in the README's "Cockpit tools" table; the git view mod is my own fork, kept outside this repo.
- Base layout: `DEVandro-light` (my clone of `main`, formerly `my-main`) with `my-spaces` and `my-agents` (clones of
  `spaces`/`agents`). Only change: the narrow sidebar rail shows space avatars
  (colored letter tiles) and agent program icons instead of numbers.
  The rail keeps the full list's row and header heights (empty title space, a short rule per
  agent group, sub-agents as small icons), so icons don't jump vertically when folding.
- `cmd-b` toggles the sidebar between the rail (50 px; was 76) and its last width (via `my-agents.toggle-sidebar`).
- No Files/Changes side panel: removed from `DEVandro`, and shared `workspace.panels` is `[]` so the tab bar shows no buttons for them.

## Themes
- Each `themes/*.json` (except win98) sets `colors.chrome` to its palette's sidebar color
  (rose-pine `#1f1d2e`, catppuccin mantle, etc.) so the sidebar/bars follow the theme
  instead of Herdr's derived neutral. New theme files need their own `chrome`.
- `my-spaces` avatars use the theme's ANSI colors (not the shipped fixed `MARK` table),
  letter in theme background/foreground by contrast.

## Publishing changes (GitHub repo)
- This folder is also the git repo `ECaxala/herdr-setup` (remote `origin`, branch `main`).
  `.gitignore` tracks only an allowlist: `README.md`, `install.sh`, `keys.json`,
  `settings.json`, `layouts/DEVandro.json`, `layouts/DEVandro-light.json`, `mods/my-*`, `themes/`, `AGENTS.local.md`.
- After you change anything tracked (layout, my-* mod, theme, keys, settings, install.sh),
  or add a new layout/mod/theme, **ask me** whether to commit and push. Don't push on
  your own. I may decline; stage only files that belong to the change I asked for.
- Before asking, keep the repo consistent:
  - New layout, mod or theme: add a `!` line to `.gitignore`. For a new mod or layout,
    also update `MODS`/`LAYOUT` in `install.sh`.
  - Whenever a tool is added to, changed in or removed from the cockpit (`DEVandro`), update the README's "Cockpit tools" table (what it's for, how it fits the workflow, where to get it) and `COCKPIT_MODS` in `install.sh`.
  - Update `README.md` (contents table, key table, install/remove steps) if what the
    setup contains or does changed.
  - Run `herdr-app check` on any changed mod and `sh -n install.sh` if it changed.
  - Update this file if the setup's behavior changed.
- Write a short commit message about what changed. Note any other modified files
  you left out of the commit.
