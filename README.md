# herdr-setup

A ready-made desktop for [Herdr](https://herdr.dev), built for working with coding
agents. Everything lives in one window: your projects on the left, the agents
running in them under that, your terminals in the middle.

Pick one of two versions:

| | **DEVandro-light** | **DEVandro** (the cockpit) |
|---|---|---|
| For | A clean, fast base | Running several agents and reviewing what they did |
| Extra installs | None | The tools listed [below](#cockpit-tools) |

## What you get (both versions)

- **Projects and agents in one sidebar.** Spaces (one per project) with the
  agents working in each, so you see at a glance who is working, waiting for you or done.
- **Fold it to a slim rail** with `cmd-b`. Projects become colored letter tiles and
  agents show their program icon, so nothing is lost when the sidebar is small.
- **Keyboard first.** `ctrl-h/l` switch tabs, `ctrl-k/j` switch projects,
  `ctrl-shift-k/j` jump between agents, `ctrl-alt-h/j/k/l` move between panes.
  Full list [below](#keys-optional).
- **Themes that match.** Catppuccin, Rosé Pine and Tokyo Night (light and dark);
  the sidebar and bars follow the theme.
- **Tabs, split terminals as cards, status bar:** Herdr's standard layout, with the
  Files/Changes panels removed to keep it quiet.

## What the cockpit adds (DEVandro)

Everything above, plus a **git panel on the right** (hidden until you open it) to
review what an agent changed: files, diffs, staging and history, without leaving the
window. That panel comes from a separate tool, so the cockpit grows as tools are added.

### Cockpit tools

| Tool | What it's for | How it fits the workflow |
|---|---|---|
| `gitview` | Review changes: files, diffs, staging, history | An agent finishes, you open the panel, check the diff, commit |

*More tools will be added here. Where to get each one is noted next to it; a missing
tool only leaves its panel empty, the layout still works.* `./install.sh --full`
tells you which tools you don't have yet.

## Install


Herdr's config lives in `~/.config/herdr-app`. **Don't clone this repo over
it.** Copy the parts you want instead:

```sh
git clone https://github.com/ECaxala/herdr-setup.git /tmp/herdr-setup
cd /tmp/herdr-setup
./install.sh --dry-run   # see what it would do
./install.sh             # install DEVandro-light
./install.sh --full      # also install DEVandro, the cockpit
```

The script copies the layout, the two mods and the themes into
`~/.config/herdr-app`, **skips anything that already exists**, runs
`herdr-app check` on both mods and switches to `DEVandro-light` (or `DEVandro` with `--full`). With `--full` it also tells you which cockpit mods you still need to add (see [Cockpit tools](#cockpit-tools)); the layout loads without them, their panel is just empty. It makes no network
calls. Add `--keys` to install `keys.json` too (see below). Set
`HERDR_APP_HOME` to install somewhere other than `~/.config/herdr-app`.

<details>
<summary>Manual install</summary>

```sh
H=~/.config/herdr-app

cp layouts/DEVandro-light.json "$H/layouts/"   # add layouts/DEVandro.json for the cockpit
cp -R mods/my-spaces mods/my-agents "$H/mods/"
cp themes/*.json "$H/themes/"

herdr-app check "$H/mods/my-spaces"
herdr-app check "$H/mods/my-agents"
herdr-app do layout.switch --name DEVandro-light
```

</details>

- Pick a theme in Settings → Look (`cmd-,`).
- Switch back to your own layout with `ctrl-shift-l`.
- Something broken? `ctrl-alt-shift-escape` resets to Herdr's default layout.

### Keys (optional)

`./install.sh --keys` **replaces** your whole key file (the old one is saved as
`keys.json.bak-<time>`). Or copy only the lines you want. Note: `ctrl-h/j/k/l` are taken for tab/space navigation,
so the shell no longer gets them.

| Key | Action |
|---|---|
| `ctrl-h` / `ctrl-l` | previous / next tab |
| `ctrl-k` / `ctrl-j` | previous / next space |
| `ctrl-shift-k` / `ctrl-shift-j` | previous / next agent |
| `ctrl-alt-h/j/k/l` | move focus between panes |
| `cmd-b` | fold / unfold the sidebar (needs `my-agents`) |

## What's in the repo

| Path | What it is |
|---|---|
| `layouts/DEVandro-light.json` | The base layout: Herdr's `main` without the Files/Changes panels |
| `layouts/DEVandro.json` | The base plus the right-hand git panel (the cockpit) |
| `mods/my-spaces/`, `mods/my-agents/` | The sidebar mods: avatars and icons in the rail, `cmd-b` to fold |
| `themes/*.json` | Catppuccin, Rosé Pine, Tokyo Night, each with a matching sidebar color |
| `keys.json`, `settings.json` | My shortcuts and zoom/font size (optional) |
| `install.sh` | Copies the above into your Herdr home without overwriting |
| `AGENTS.local.md` | Notes for coding agents about this setup |

## Remove it

```sh
H=~/.config/herdr-app
rm "$H/layouts/DEVandro-light.json" "$H/layouts/DEVandro.json"
rm -R "$H/mods/my-spaces" "$H/mods/my-agents"
```

Herdr falls back to its `main` layout. Theme files can stay or go.

## Update this repo (owner)

The repo *is* `~/.config/herdr-app`; `.gitignore` tracks only the files above.
A new layout, mod or theme must be added to `.gitignore` with a `!` line.
