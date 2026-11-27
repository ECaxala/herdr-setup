// Open worktree…: opens Herdr's own worktree dialog (mod "worktree") for the shown
// space, then closes itself. A launcher only: mod.open can't pass props,
// so each variant is its own mod (worktree-new, worktree-new-claude,
// worktree-open). Draws nothing.

import { View, div } from "gpui-kit";
import { closeOverlay, focused, notify, openOverlay, panes, props, spaces } from "herdr";

const ACTION = "open";
const ARGV = null;

export default class WorktreeLauncher extends View {
  init(_props, cx) {
    cx.spawn(async () => {
      const own = props()?.overlay;
      const f = focused() ?? {};
      const space = spaces().find((s) => s.id === f.space) ?? spaces().find((s) => s.active);
      if (own) closeOverlay(own);
      if (!space) return notify({ title: "worktree", body: "Open a space first.", level: "warning" });
      // The focused terminal's folder picks the repo, as the + menu does.
      const folder = panes().find((p) => p.focused)?.cwd || undefined;
      const size = ACTION === "open" ? { width: 560, height: 480 } : { width: 440, height: 260 };
      openOverlay({ mod: "worktree", kind: "dialog", ...size, props: { space: space.id, folder, action: ACTION, ...(ARGV ? { argv: ARGV } : {}) } });
    });
  }

  render() {
    return div();
  }
}
