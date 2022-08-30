# Set options
# CD
setopt	auto_pushd

# Completion
setopt	always_to_end \
		no_auto_list menu_complete

# Globbing
setopt 	magic_equal_subst \
		no_case_glob no_case_paths \
		no_nomatch

# History
SAVEHIST=1000000
HISTSIZE=1000000
HISTFILE=~/.zsh_history
setopt	hist_fcntl_lock \
		hist_expire_dups_first hist_find_no_dups hist_ignore_dups hist_save_no_dups \
		hist_ignore_space hist_no_store

# Input/Output
setopt	interactive_comments

# Job control
setopt	no_bg_nice

# Prompting
setopt	prompt_subst transient_rprompt

# ZLE
setopt	no_beep

# Start in vim mode
bindkey -v

# Keybindings
bindkey "^?" backward-delete-char

autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^N" history-beginning-search-forward-end
bindkey "^P" history-beginning-search-backward-end

zmodload zsh/complist
bindkey -M menuselect '^@' vi-insert
bindkey -M menuselect '^N' menu-complete
bindkey -M menuselect '^P' reverse-menu-complete

# Bootstrap zinit
ZINIT_HOME=$HOME/.local/share/zinit/zinit
if [ ! -d $ZINIT_HOME ]; then
	mkdir -p "$(dirname $ZINIT_HOME)"
	git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# Prompt theme - Pure
PURE_GIT_PULL=0
zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
zinit light sindresorhus/pure

# Completion
autoload -Uz compinit
compinit

zstyle ':completion:*' menu select interactive search
zstyle ':completion:*' use-cache on
zstyle ':completion:*' group-name ''
zstyle ':completion:*' completer _complete _match _approximate

zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:*:*:*:descriptions' format '%F{blue}-- %D %d --%f'
zstyle ':completion:*:*:*:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:*:*:*:warnings' format ' %F{red}-- no matches found --%f'

if type dircolors > /dev/null; then
	eval $(dircolors -b)
fi
zstyle ':completion:*:*:*:*:default' list-colors ${(s.:.)LS_COLORS}

# Plugins
zinit light zsh-users/zsh-completions

# FZF
zinit ice from"gh-r" as"program" id-as"fzf-bin"
zinit load junegunn/fzf
zinit ice src"shell/key-bindings.zsh" wait lucid
zinit load junegunn/fzf

# Syntax highlighting
zinit ice wait lucid
zinit load zdharma-continuum/fast-syntax-highlighting

# Oh My Zsh plugins
zinit ice wait lucid
zinit snippet OMZP::sudo
zinit ice wait lucid
zinit snippet OMZP::gpg-agent

# Environment
path=(~/bin ~/.local/bin $path)
export EDITOR=vim
export VISUAL=$EDITOR
export PAGER=less
export AUR_PAGER=$EDITOR

# Aliases
alias ls='ls --color=auto'
alias la='ls -A'
alias ll='la -lh'
alias grep='grep --color=auto'

# Machine-specific
if [ -f ~/.zshrc.local ]; then
	. ~/.zshrc.local
fi

# Dot files management
# git clone --separate-git-dir=$HOME/.dotfiles https://gitlab.com/ilango100/dotfiles [~]
alias dotf='git --git-dir=$HOME/.dotfiles'
# dotf config core.worktree $HOME
# dotf config status.showUntrackedFiles no
