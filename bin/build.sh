#! /bin/zsh

##############################################################3
# Symlink RC files
##############################################################3

if [[ ! -a ~/.zshrc ]]; then
  ln -s ~/git/dotfiles/zshrc ~/.zshrc
fi

if [[ ! -a ~/.gitconfig ]]; then
  ln -s ~/git/dotfiles/gitconfig ~/.gitconfig
fi

if [[ ! -a ~/.zshenv ]]; then
  ln -s ~/git/dotfiles/zshenv ~/.zshenv
fi

if [[ ! -a ~/.tmux.conf ]]; then
  ln -s ~/git/dotfiles/tmux.conf ~/.tmux.conf
fi

if [[ ! -a ~/.config/nvim/init.vim ]]; then
  mkdir -p ~/.config/nvim
  ln -s ~/git/dotfiles/init.vim ~/.config/nvim/init.vim
fi

source ~/.zshenv
proxy on

###################################################################################################
# Setup init.vim
# 1. Check if git is installed
# 2. Install Neovim
# 4. Install Vundle
# 5. Install all plugins
# 6. Install node using nvm
###################################################################################################

if ! [ -x "$(command -v git)" ]; then
  echo 'Error: git is not installed.' >&2
  exit 1
fi

if ! [ -x "$(command -v nvim)" ]; then
  zsh ~/git/dotfiles/bin/install-neovim.sh
fi

if ! [ -x "$(command -v ag)" ]; then
  zsh ~/git/dotfiles/bin/install-ag.sh
fi

if ! [ -x "$(command -v fzf)" ]; then
  zsh ~/git/dotfiles/bin/install-fzf.sh
fi

if ! [ -x "$(command -v node)" ]; then
  zsh ~/git/dotfiles/bin/install-node.sh
fi

if ! [ -x "$(command -v bat)" ]; then
  zsh ~/git/dotfiles/bin/install-bat.sh
fi

if [[ ! -a ~/.local/share/nvim/site/autoload/plug.vim ]]; then
  echo "Installing vim-plug..."
  zsh ~/git/dotfiles/bin/install-vim-plug.sh
fi

# Install vundle plugins
echo "Installing neovim plugins"
nvim -c 'PlugInstall' -c 'qa!'

# Install needed modules
sudo pip3.6 install neovim
nvim -c 'UpdateRemotePlugins' -c 'qa!'

nvim +'CocInstall -sync coc-tsserver coc-eslint coc-json coc-prettier coc-css' +qall
nvim +CocUpdateSync +qall

if [[ ! -a ~/.config/nvim/coc-settings.json ]]; then
  echo "Linking coc-settings.json..."
  mkdir -p ~/.config/nvim
  ln -s ~/git/dotfiles/coc-settings.json ~/.config/nvim/coc-settings.json
fi

if [[ ! -a ~/git/nodejs ]]; then
  zsh ~/git/dotfiles/bin/setup-nodejs.git.sh
fi
