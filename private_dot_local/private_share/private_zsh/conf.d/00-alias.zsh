# vim: set filetype=sh :

alias b='cargo build'
alias blame='systemd-analyze blame'
alias boot='systemd-analyze'
alias br='cargo build --release'
alias c='clear'
alias cargopwd='cargo install --force --path $PWD'
alias cargogit='cargo install --force --git'
alias chown='sudo chown -R $USER:users'
alias cin='cargo install --force --path $PWD'
alias cig='cargo install --git'
alias clone='git clone'
alias code='code-oss'
alias crit='systemd-analyze critical-chain'
alias dots='chezmoi'
alias find='fd'
alias fcu='sudo compsize /btrfs'
alias gt='cd $(fd -H -t d -j 12 | fzy -j 4)'
alias play='mpv --hwdec=auto'
alias ngr='sudo nginx -s reload'
alias mem='free -h --si'
alias r='cargo run'
alias rr='cargo run --release'
alias sudoenv='sudo env PATH=$PATH'
alias suvim='sudo -E nvim'
alias t='cargo test --release -- --nocapture'
alias tokei='tokei -s=lines'
alias tst='hyperfine'
alias tstc='hyperfine --prepare "sync; echo 3 | sudo tee /proc/sys/vm/drop_caches"'
alias tstw='hyperfine -w 10'
alias xo='xdg-open &>/dev/null'
alias xsetkeyr='xset r rate 182 42'
alias wininfo='swaymsg -t get_tree'

alias zshrc='nvim ~/.zshrc && source ~/.zshrc'
alias aliasrc='nvim $XDG_DATA_HOME/zsh/conf.d/00-alias.zsh && source $XDG_DATA_HOME/zsh/conf.d/00-aliasrc' # Hide from ali
alias distrorc='nvim $XDG_DATA_HOME/zsh/conf.d/01-distro-specifi.zsh && source $XDG_DATA_HOME/zsh/conf.d/01-distro-specifi.zsh' # Hide from ali
alias sysrc='nvim $XDG_DATA_HOME/zsh/conf.d/02-system.zsh && source $XDG_DATA_HOME/zsh/conf.d/02-system.zsh' # Hide from ali
alias typorc='nvim $XDG_DATA_HOME/zsh/conf.d/03-typo.zsh && source $XDG_DATA_HOME/zsh/conf.d/03-typo.zsh' # Hide from ali
alias misc='nvim $XDG_DATA_HOME/zsh/conf.d/10-miscellanerous.zsh && $XDG_DATA_HOME/zsh/conf.d/10-miscellanerous.zsh' # Hide from ali

if which rsync >/dev/null 2>&1; then
	alias scp='rsync -avzhe ssh --progress'
fi
