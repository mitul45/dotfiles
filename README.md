# dotfiles
collection of dotfiles

# .vimrc
1. Install [Neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim)
1. Install [Vundle](https://github.com/VundleVim/Vundle.vim)  
   `$ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim`
1. Clone this repo, and link `~/.config/nvim/init.vim` to [this](https://github.com/mitul45/dotfiles/blob/master/vimrc) file  
   `$ git clone git@github.com:mitul45/dotfiles.git`  
   `$ cd dotfiles`  
   `$ ln -s ~/.vim ~/.config/nvim`  
   `$ ln -s vimrc ~/.config/nvim/init.vim`
1. Open Neovim (`nvim`) and run `:PluginInstall`
1. Run `npm install` for `tern_for_vim`  
   `$ cd ~/.vim/bundle/tern_for_vim`  
   `$ npm install`
1. Follow [nvim+python support](https://github.com/zchee/deoplete-jedi/wiki/Setting-up-Python-for-Neovim)  
   `$ sudo pip install neovim`  
   run `:UpdateRemotePlugins` in neovim [[Reference](https://github.com/Shougo/deoplete.nvim)]
1. Install [`fzf`](https://github.com/junegunn/fzf#installation) for crazy fast file search
   
# .zshrc
1. Install [zsh](https://github.com/robbyrussell/oh-my-zsh/wiki/Installing-ZSH)
1. Set zsh as default shell - `chsh -s $(which zsh)` (you might need to logoff, and login again to see it in action)
1. Link file  
    `$ ln -s ~/git/dotfiles/zshrc ~/.zshrc`
