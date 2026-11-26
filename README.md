# herdr-setup

My [Herdr](https://herdr.dev) desktop setup: the `DEVandro` layout, two sidebar
mods, extra themes and hjkl-style keys.

## What's inside

| Path | What it is |
|---|---|
| `layouts/DEVandro.json` | Clone of Herdr's `main`, without the Files/Changes panels |
| `mods/my-spaces/`, `mods/my-agents/` | Clones of `spaces` / `agents`: the narrow sidebar shows space avatars and agent icons; `cmd-b` folds the sidebar |
| `themes/*.json` | Catppuccin, Rosé Pine, Tokyo Night (light + dark), each with a matching sidebar color |
| `keys.json` | My shortcuts (optional, see below) |
| `install.sh` | Copies the above into your Herdr home without overwriting |
| `settings.json` | My zoom and font size (optional) |
| `AGENTS.local.md` | Notes for coding agents about this setup |

## Use it

Herdr's config lives in `~/.config/herdr-app`. **Don't clone this repo over
it.** Copy the parts you want instead:

```sh
git clone https://github.com/ECaxala/herdr-setup.git /tmp/herdr-setup
cd /tmp/herdr-setup
./install.sh --dry-run   # see what it would do
./install.sh             # install
```

The script copies the layout, the two mods and the themes into
`~/.config/herdr-app`, **skips anything that already exists**, runs
`herdr-app check` on both mods and switches to `DEVandro`. It makes no network
calls. Add `--keys` to install `keys.json` too (see below). Set
`HERDR_APP_HOME` to install somewhere other than `~/.config/herdr-app`.

<details>
<summary>Manual install</summary>

```sh
H=~/.config/herdr-app

cp layouts/DEVandro.json "$H/layouts/"
cp -R mods/my-spaces mods/my-agents "$H/mods/"
cp themes/*.json "$H/themes/"

herdr-app check "$H/mods/my-spaces"
herdr-app check "$H/mods/my-agents"
herdr-app do layout.switch --name DEVandro
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

## Remove it

```sh
H=~/.config/herdr-app
rm "$H/layouts/DEVandro.json"
rm -R "$H/mods/my-spaces" "$H/mods/my-agents"
```

Herdr falls back to its `main` layout. Theme files can stay or go.

## Update this repo (owner)

The repo *is* `~/.config/herdr-app`; `.gitignore` tracks only the files above.
A new layout, mod or theme must be added to `.gitignore` with a `!` line.
