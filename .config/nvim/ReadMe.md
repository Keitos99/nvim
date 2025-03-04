# TODO

## Tmux resize support

- resize using tmux if:
  - Case1: two pane and nvim has only one window: nvim window is at left edge of tab && and there is pane left to nvim. The same for right
    - move with tmux
  - Case 2: two panes and two nvim window. nvim is on the right pane. Press M-l
    - on right nvim window then: use nvim logic
    - on left nvim window: use nvim logic
    - on left pane: use tmux logic
  - Case 2: two panes and two nvim window. nvim is on the right pane. Press M-h
    - on right nvim window then: use nvim logic
    - on left nvim window: use nvim logic
    - on left pane: use tmux logic
