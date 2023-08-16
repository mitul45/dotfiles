echo "Installing rust (for compiling bat)"
# bat needs to built from sources, so install rust first
curl https://sh.rustup.rs -sSf | sh
source $HOME/.cargo/env
cd ~/git
echo "Cloning bat repo"
git clone https://github.com/sharkdp/bat.git
cd bat
echo "Installing bat..."
cargo install --locked bat
