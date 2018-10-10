#! /bin/zsh

##############################################################3
# Symlink RC files
##############################################################3

if [[ ! -a ~/.zshrc ]]; then
  ln -s ~/.dotfiles/zshrc ~/.zshrc
fi

if [[ ! -a ~/.zshenv ]]; then
  ln -s ~/.dotfiles/zshenv ~/.zshenv
fi

if [[ ! -a ~/.tmux.conf ]]; then
  ln -s ~/.dotfiles/tmux.conf ~/.tmux.conf
fi

if [[ ! -a ~/.gitconfig ]]; then
  ln -s ~/.dotfiles/gitconfig ~/.gitconfig
fi

if [[ ! -a ~/.gitconfig ]]; then
  ln -s ~/.dotfiles/vimrc ~/.vimrc
fi

source ~/.zshenv
proxy on

###################################################################################################
# Setup .vimrc
# 1. Check if git is installed
# 2. Install Neovim
# 3. Link .vimrc
# 4. Install Vundle
# 5. Install all plugins
###################################################################################################

if ! [ -x "$(command -v git)" ]; then
  echo 'Error: git is not installed.' >&2
  exit 1
fi

if ! [ -x "$(command -v nvim)" ]; then
  zsh ~/.dotfiles/bin/install-neovim.sh
fi

if ! [ -x "$(command -v ag)" ]; then
  zsh ~/.dotfiles/bin/install-ag.sh
fi

if [[ ! -a ~/.config/nvim/init.vim ]]; then
  echo "Linking vimrc..."
  mkdir -p ~/.config/nvim
  ln -s ~/.dotfiles/vimrc ~/.config/nvim/init.vim
fi

if [[ ! -a ~/.vim/bundle/Vundle.vim ]]; then
  echo "Installing Vundle..."
  mkdir -p ~/.vim/bundle
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

# Install vundle plugins
echo "Installing vim plugins"
nvim -c 'PluginInstall' -c 'qa!'

# Install needed modules
sudo pip3.6 install neovim
nvim -c 'UpdateRemotePlugins' -c 'qa!'

# Install fzf
if ! [ -x "$(command -v fzf)" ]; then
  zsh ~/.dotfiles/bin/install-fzf.sh
fi

## Setup flag
touch ~/.dotfiles/SETUP
