echo "Installing nvm..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
source ~/.zshrc
echo "Installing node latest LTS..."
nvm install --lts
echo "Installing yarn..."
npm install --global yarn
