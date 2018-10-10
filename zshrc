autoload -U colors && colors

###################################################################################################
# Prompt Settings
# http://arjanvandergaag.nl/blog/customize-zsh-prompt-with-vcs-info.html
# https://www-s.acm.illinois.edu/workshops/zsh/prompt/escapes.html
###################################################################################################
autoload -Uz vcs_info
zstyle ':vcs_info:git*' formats "%{$fg[red]%}(%{$reset_color%}%{$fg[blue]%}%b%{$reset_color%}%{$fg[red]%})%{$reset_color%} %{$fg[yellow]%}%a%{$reset_color%}"
precmd() { vcs_info }

setopt prompt_subst
PROMPT='%{$fg[red]%}[%{$reset_color%}%{$fg[blue]%}%T%{$reset_color%}%{$fg[red]%}]%{$reset_color%} %{$fg[green]%}%m%{$reset_color%}%{$fg[red]%}:%{$reset_color%}%{$fg[green]%}%~%{$reset_color%} ${vcs_info_msg_0_} >> '

###################################################################################################
# History related stuff
###################################################################################################
# Keep 10000 lines of history within the shell and save it to ~/.zsh_history:
setopt histignorealldups sharehistory

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Make up/down arrow key search for similar command in history
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

###################################################################################################
# Better autocomplete
###################################################################################################
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
if whence dircolors >/dev/null; then
  eval "$(dircolors -b)"
  zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
  alias ls='ls --color'
else
  export CLICOLOR=1
  zstyle ':completion:*:default' list-colors ''
fi
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

###################################################################################################
# Misc
###################################################################################################
# use Ctrl+Z to bring process to foreground
_zsh_cli_fg() { fg; }
zle -N _zsh_cli_fg
bindkey '^Z' _zsh_cli_fg

# Prettier cat
if [ -x "$(command -v bat)" ]; then
  alias cat=bat
fi

# Make delete key work
bindkey    "^[[3~"          delete-char
bindkey    "^[3;5~"         delete-char

source ~/.zshenv
