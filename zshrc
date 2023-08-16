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

if [[ -f "~/.zshenv" ]]; then
  source ~/.zshenv
fi

alias ll='ls -laFh'
alias k='kubectl'
alias j='joplin'
alias n='nvim'
alias what-is-my-url="kubectl describe svc | grep kubernetes.fqdn | tr -d ' ' | cut -d: -f2"
if [[ $OSTYPE == 'darwin'* ]]; then
  alias gg="cd ~/git/main/apps/golem/partner/extranet/genius"
else
  alias gg="cd /usr/local/git_tree/main/apps/golem/partner/extranet/genius"
fi

export FZF_DEFAULT_COMMAND="find * -type f"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# BK plugin autocomplete
# NOTE: This takes a lot of time and slows down the initial load
source <(bk completion zsh)

# Bazel stuff
export PATH="$PATH:$HOME/bin"

# This way the completion script does not have to parse Bazel's options
# repeatedly.  The directory in cache-path must be created manually.
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true

# fzf examples
# https://github.com/junegunn/fzf/wiki/examples

# Use fd and fzf to get the args to a command.
# Works only with zsh
# Examples:
# f mv # To move files. You can write the destination after selecting the files.
# f 'echo Selected:'
# f 'echo Selected music:' --extention mp3
# fm rm # To rm files in current directory
f() {
    sels=( "${(@f)$(fd "${fd_default[@]}" "${@:2}"| fzf)}" )
    test -n "$sels" && print -z -- "$1 ${sels[@]:q:q}"
}

# Like f, but not recursive.
fm() f "$@" --max-depth 1

# fh - repeat history
fh() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -E 's/ *[0-9]*\*? *//' | sed -E 's/\\/\\\\/g')
}


# fbr - checkout git branch (including remote branches), sorted by most recent commit, limit 30 last branches
fbr() {
  local branches branch
  branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# Set default editor to nvim
export VISUAL=nvim
export EDITOR="$VISUAL"

export DENO_INSTALL="/$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
export PATH=~/.npm-global/bin:$PATH
export PATH="$HOME/.local/bin:$PATH"
# pyenv
export PATH=$(pyenv root)/shims:$PATH

# PCRE: https://apple.stackexchange.com/a/414625
export CPATH=/opt/homebrew/include
export LIBRARY_PATH=/opt/homebrew/lib

# Run `nvm use` if a folder has `.nvmrc` file automatically after `cd`ing into it
# https://github.com/nvm-sh/nvm#calling-nvm-use-automatically-in-a-directory-with-a-nvmrc-file
# place this after nvm initialization!
autoload -U add-zsh-hook
load-nvmrc() {
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
      nvm use
    fi
  elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
