# Disable System Prompt
cd && touch .hushlogin

# Oh-My-Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Starship
curl -sS https://starship.rs/install.sh | sh

# Node Version Manager
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

# Node
nvm install node

# Global NPM Modules
npm install --global serve
npm install --global live-server
npm install --global @google/gemini-cli

# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Git
brew install git-extras
brew install lazygit

# Docker
brew install docker
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

# System
brew install nvim
brew install bat
brew install fzf
brew install yazi
brew install wget

brew install duti python-yq
curl "https://raw.githubusercontent.com/github/linguist/master/lib/linguist/languages.yml" \
  | yq -r "to_entries | (map(.value.extensions) | flatten) - [null] | unique | .[]" \
  | xargs -L 1 -I "{}" duti -s dev.zed.Zed {} all

# Graphics
brew install imagemagick 
brew install ffmpeg 
brew install shntool 
brew install ghostscrip
brew install webp
