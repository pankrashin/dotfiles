+-----------------------+
|    TERMINAL & CLI     |
+-----------------------+

# Disable MOTD
cd && touch .hushlogin

# Install Oh-My-Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Starship shell prompt
curl -sS https://starship.rs/install.sh | sh

# Configure git
git config --global user.name "Daniil Pankrashin"
git config --global user.email "daniil@pankrashin.com"

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# System
brew install fastfetch
brew install nvim
brew install bat
brew install fzf
brew install wget

# Git
brew install lazygit

# Containers
brew install --cask docker
brew install lima
brew install colima
brew install lazydocker

# PHP
brew install php
brew install composer
composer global require laravel/installer

# Ruby
brew install rbenv

# Go
brew install go

# Graphics
brew install imagemagick 
brew install ffmpeg 
brew install shntool 
brew install ghostscrip
brew install webp

+-----------------------+
|    HOMEBREW CASKS     |
+-----------------------+

# Ghostty
brew install --cask ghostty

# XPipe
brew install --cask xpipe-io/tap/xpipe

# Visual Studio Code
brew install --cask visual-studio-code

cat << EOF >> ~/.zshrc
# Add Visual Studio Code (code)
export PATH="\$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
EOF

source ~/.zshrc

code --install-extension vscode-icons-team.vscode-icons # vscode-icons
code --install-extension tonybaloney.vscode-pets #vscode-pets
code --install-extension esbenp.prettier-vscode # Prettier
code --install-extension usernamehw.errorlens # Error Lens
code --install-extension ms-vscode.cpptools-extension-pack # C/C++ Extension Pack
code --install-extension ms-python.python # Python
code --install-extension ms-toolsai.jupyter # Jupiter

# Make vscode default editor
brew install duti python-yq
curl "https://raw.githubusercontent.com/github/linguist/master/lib/linguist/languages.yml" \
  | yq -r "to_entries | (map(.value.extensions) | flatten) - [null] | unique | .[]" \
  | xargs -L 1 -I "{}" duti -s com.microsoft.VSCode {} all


