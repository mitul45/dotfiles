# dotfiles
collection of dotfiles

# init.vim
1. Install [Neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim)
1. Install [vim-plug](https://github.com/junegunn/vim-plug)
1. Clone this repo, and link `~/.config/nvim/init.vim` to `init.vim`
    ```
    ln -s ~/git/dotfiles/init.vim ~/.config/nvim/init.vim
    ```
1. Open Neovim (`nvim`) and run `:PlugInstall`
1. Install coc plugins: `:CocInstall coc-tsserver coc-eslint coc-json coc-prettier coc-css`
1. Link `coc-settings.json`
    ```
    ln -s ~/git/dotfiles/coc-settings.json ~/.vim/coc-settings.json
    ```
1. Install [`fzf`](https://github.com/junegunn/fzf#installation) and [`ag`](https://github.com/ggreer/the_silver_searcher)
1. If you see "requires python" error, install `pip3 install neovim`


# .zshrc
1. Install [zsh](https://github.com/robbyrussell/oh-my-zsh/wiki/Installing-ZSH)
1. Set zsh as default shell - `chsh -s $(which zsh)` (you might need to logoff, and login again to see it in action)
1. Link file  
    `$ ln -s ~/git/dotfiles/zshrc ~/.zshrc`

