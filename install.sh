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
npm install —-global serve
npm install —-global live-server
npm install --global @google/gemini-cli

# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install bat
brew install fzf
brew install yazi
brew install wget
brew install rbenv

brew install duti python-yq
curl "https://raw.githubusercontent.com/github/linguist/master/lib/linguist/languages.yml" \
  | yq -r "to_entries | (map(.value.extensions) | flatten) - [null] | unique | .[]" \
  | xargs -L 1 -I "{}" duti -s dev.zed.Zed {} all

# graphics packages
brew install magick ffmpeg shntool ghostscript webp
