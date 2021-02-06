darkGoldenrod="#eead0e"
bg="#fbf8ef"
bg2="#efeae9"
act1="#e7e5eb"
base="#655370"
purple="#d3d3e7"
comp="#6c4173"

# pane border
set -g pane-border-style fg='#6272a4'
set -g pane-active-border-style fg='#ff79c6'

set -g status-style bg='#d3d3e7',fg='#655370'

# window status
run-shell ~/.config/tmux/colors/window/spacelight
set-window-option -g window-status-format ""
set-window-option -g window-status-current-format ""

# status left
# are we controlling tmux or the content of the panes?
set -g status-left "#[bg=${darkGoldenrod}]#[fg=${act1}] #(~/.config/tmux/scripts/left_icon)#[fg=${darkGoldenrod}, bg=${act1}] #[fg=${comp}, bg=${act1}]#{pane_current_command} "

# status right

# Setting #(~/.config/tmux/colors/window/spacelight) is hack to get around
# setting the window options dynamically and self refreshing
set -g status-right "#[fg=${purple}, bg=${act1}]#[fg=${base}, bg=${act1}] #(~/.config/tmux/scripts/cpu)%#(~/.config/tmux/colors/window/spacelight) "
set -ga status-right "#[fg=${purple},bg=${act1}]#[fg=${base}, bg=${purple}] #(~/.config/tmux/scripts/uptime) "
set -ga status-right "#[fg=${purple},bg=${act1}]#[fg=${base}, bg=${act1}] #(~/.config/tmux/scripts/battery -q)| %a %H:%M "
