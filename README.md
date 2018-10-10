## dotfiles
Collection of various dotfiles

----
### zshrc
![image](https://user-images.githubusercontent.com/6790325/46727836-b2f44300-cc81-11e8-8227-97c9defe035e.png)
* Customized prompt with branch information for git repositories
* Better autocomplete
* Up key to iterate through same commands ran in history

#### Installation
* Install [zsh](https://github.com/robbyrussell/oh-my-zsh/wiki/Installing-ZSH) and [bat](https://github.com/sharkdp/bat#installation)
* Set `zsh` as default shell – `chsh -s $(which zsh)` (might need a fresh login)
* `ln -s ~/git/dotfiles/zshrc ~/.zshrc`

---
### vimrc
![image](https://user-images.githubusercontent.com/6790325/46729152-cead1880-cc84-11e8-9769-0549c82b86bf.png)  

* Solarized color theme
* Easy search for any term across large code-base with `ack`
* Fuzzy file search within vim with `fzf`
* Simpler navigation between open buffers/files using `airline`
* Persistent undo, so that even if you close vim and re-open the file – undo works as expected.
* Music controls for Spotify (including search) while you are coding!
* File explorer using `NERDTree`

#### Some shortcuts (with `g` as mapleader)
* `jk` for `Esc`
* For easier navigation between open files
  * `gn` - move to next open file
  * `gp` - Move to previous open file.
  * `gh` - Close buffer
* `WQ = Wq = wq` in command mode to avoid having typos while exiting a file
* `gy` for copying to clipboard
* `gc<space>` to toggle comments
* `<ctrl>+d` to generate JSdocs
* `gs` to search the word under cursor using `Ctrlsf`
* `<ctrl>+p` to find a file using fuzzy search (`fzf`)
* `tt` to open file explorer tree view and highlight current file inside it

#### Installation
* Install [Neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim), [fzf](https://github.com/junegunn/fzf#installation), [Vundle](https://github.com/VundleVim/Vundle.vim), and [ack](https://beyondgrep.com/install/).
    ```   
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    ln -s ~/.vim ~/.config/nvim
    ln -s vimrc ~/.config/nvim/init.vim
    ```
* Open Neovim (`nvim`) and run `:PluginInstall`
* Install dependencies for `tern_for_vim`  
   ``` 
   cd ~/.vim/bundle/tern_for_vim  
   npm install
   ```
* Follow [Neovim + python support](https://github.com/zchee/deoplete-jedi/wiki/Setting-up-Python-for-Neovim)  
   `sudo pip install neovim`  
   run `:UpdateRemotePlugins` in neovim [[Reference](https://github.com/Shougo/deoplete.nvim)]
