echo "Installing fzf..."
mkdir -p ~/git && cd ~/git
git clone --depth 1 https://github.com/junegunn/fzf.git ~/git/fzf
sh ~/git/fzf/install
