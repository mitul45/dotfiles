echo "Installing NeoVim and it's dependencies..."
sudo yum -y install libtool autoconf automake cmake gcc gcc-c++ make pkgconfig unzip
mkdir -p ~/git && cd ~/git
git clone https://github.com/neovim/neovim.git && cd neovim
make -j
sudo make install
