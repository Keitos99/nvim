# TODO

## Tmux resize support

- Resize using Tmux if:
  - Case 1: Two panes and Neovim has only one window: Neovim window is at the left edge of the tab, and there is a pane to the left of Neovim. The same applies for the right.
    - Move with Tmux.
  - Case 2: Two panes and two Neovim windows. Neovim is on the right pane. Press `M-l`:
    - On the right Neovim window: use Neovim logic.
    - On the left Neovim window: use Neovim logic.
    - On the left pane: use Tmux logic.
  - Case 2: Two panes and two Neovim windows. Neovim is on the right pane. Press `M-h`:
    - On the right Neovim window: use Neovim logic.
    - On the left Neovim window: use Neovim logic.
    - On the left pane: use Tmux logic.
