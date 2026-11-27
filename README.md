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
- **Worktrees as spaces, from the keyboard.** `cmd-shift-n` creates a git worktree
  and opens it as its own space, `cmd-alt-n` does the same and starts Claude in it,
  `cmd-shift-o` reopens an existing one. Worktree spaces sit under their repo with a
  folder-tree icon. Details [below](#worktrees).
- **Tabs, split terminals as cards, status bar:** Herdr's standard layout, with the
  Files/Changes panels removed to keep it quiet.

## What the cockpit adds (DEVandro)

Everything above, plus a **git panel on the right** (hidden until you open it) to
review what an agent changed: files, diffs, staging and history, without leaving the
window. That panel comes from a separate tool, so the cockpit grows as tools are added.

### Cockpit tools

| Tool | What it's for | How it fits the workflow |
|---|---|---|
| [`gitview`](https://github.com/ECaxala/herdr-gitview) | Review changes: files, diffs, staging, history. My fork adds opt-in vim motions in the diff pane (`V`) | An agent finishes, you open the panel, check the diff, commit |

*More tools will be added here. Where to get each one is noted next to it; a missing
tool only leaves its panel empty, the layout still works.* `./install.sh --full`
tells you which tools you don't have yet and offers to install `gitview` from the fork
(`curl -fsSL https://raw.githubusercontent.com/ECaxala/herdr-gitview/main/install.sh | sh -s -- --app`).

## Worktrees

Herdr's idea: **one space per git worktree**. A space follows its terminal's folder, so
the sidebar, the git panel (`cmd-g`) and the agent all point at the same checkout. A
worktree an agent creates internally (e.g. Claude's `EnterWorktree`) stays invisible:
the space keeps showing the main checkout. This setup makes the Herdr way the easy way.

**From the keyboard or the palette** (`cmd-shift-p`, group "Worktree"):

| Key | Palette | What it does |
|---|---|---|
| `cmd-shift-n` | New worktree… | Herdr's own dialog: branch name in, new worktree + space out |
| `cmd-alt-n` | New worktree with Claude… | Same, and the new space starts `claude` |
| `cmd-shift-o` | Open worktree… | Lists the repo's worktrees (`git worktree list`, wherever they live) and opens one as a space |

They act on the space you're in and branch off the checkout you're in. Closing a space
keeps the worktree on disk; reopen it with `cmd-shift-o`. Delete it with the space's
right-click menu → Remove worktree.

**For agents: `herdr-worktree`** (installed to `~/.local/bin`) does the same from a shell,
so a coding agent can hand work off into its own space:

```sh
herdr-worktree slice/alarm-history --base origin/main --task "Implement …"
```

- The **branch** keeps your team's format and is pushed as is (no `worktree-…` names to rename).
- The **folder** is Herdr's: `~/.herdr/worktrees/<repo>/<branch with / as ->`, also the space name.
  Set `"worktrees": {"directory": "…"}` in `settings.json` to move it.
- `--task` starts `claude` in the new space with that first message; `--no-agent` opens
  only a shell; `--focus` switches to it; `--name` overrides the folder name.

To make an agent use it, add something like this to your `CLAUDE.md` / `AGENTS.md`:

```md
## Worktrees (Herdr)
- If `git rev-parse --git-dir` differs from `--git-common-dir`, you are already in a worktree: work there.
- Otherwise, for new work, run `herdr-worktree <branch> --base origin/main --task "<self-contained task>"`,
  report the branch and path, and stop. Branch names follow our normal feature-branch format.
- Never use `EnterWorktree`, `claude --worktree` or `.claude/worktrees/` for work that gets reviewed.
```

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

The script copies the layout, the mods and the themes into
`~/.config/herdr-app` and `herdr-worktree` into `~/.local/bin`, **skips anything that already exists**, runs
`herdr-app check` on the mods and switches to `DEVandro-light` (or `DEVandro` with `--full`). With `--full` it also tells you which cockpit mods you still need to add (see [Cockpit tools](#cockpit-tools)); the layout loads without them, their panel is just empty. It makes no network
calls. Add `--keys` to install `keys.json` too (see below). Set
`HERDR_APP_HOME` to install somewhere other than `~/.config/herdr-app`.

<details>
<summary>Manual install</summary>

```sh
H=~/.config/herdr-app

cp layouts/DEVandro-light.json "$H/layouts/"   # add layouts/DEVandro.json for the cockpit
cp -R mods/my-spaces mods/my-agents mods/worktree-new mods/worktree-new-claude mods/worktree-open "$H/mods/"
cp themes/*.json "$H/themes/"
mkdir -p ~/.local/bin && cp bin/herdr-worktree ~/.local/bin/

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
| `cmd-g` / `cmd-shift-g` | git view in its own tab / as sidebar (needs `gitview`) |
| `cmd-shift-n` / `cmd-alt-n` / `cmd-shift-o` | new worktree / new worktree with Claude / open worktree |

## What's in the repo

| Path | What it is |
|---|---|
| `layouts/DEVandro-light.json` | The base layout: Herdr's `main` without the Files/Changes panels |
| `layouts/DEVandro.json` | The base plus the right-hand git panel (the cockpit) |
| `mods/my-spaces/`, `mods/my-agents/` | The sidebar mods: avatars and icons in the rail, `cmd-b` to fold, folder-tree icon for worktree spaces ([Lucide](https://lucide.dev), ISC) |
| `mods/worktree-new/`, `mods/worktree-new-claude/`, `mods/worktree-open/` | Launchers that open Herdr's worktree dialog from a key or the palette |
| `bin/herdr-worktree` | Create a worktree + space from a shell (for agents) |
| `themes/*.json` | Catppuccin, Rosé Pine, Tokyo Night, each with a matching sidebar color |
| `keys.json`, `settings.json` | My shortcuts and zoom/font size (optional) |
| `install.sh` | Copies the above into your Herdr home without overwriting |
| `AGENTS.local.md` | Notes for coding agents about this setup |

## Remove it

```sh
H=~/.config/herdr-app
rm "$H/layouts/DEVandro-light.json" "$H/layouts/DEVandro.json"
rm -R "$H/mods/my-spaces" "$H/mods/my-agents" "$H/mods/worktree-new" "$H/mods/worktree-new-claude" "$H/mods/worktree-open"
rm ~/.local/bin/herdr-worktree
```

Herdr falls back to its `main` layout. Theme files can stay or go.

## Update this repo (owner)

The repo *is* `~/.config/herdr-app`; `.gitignore` tracks only the files above.
A new layout, mod or theme must be added to `.gitignore` with a `!` line.
