#!/bin/bash

# A script to set up a new macOS machine for my development work.
#
# Warning: This script is opinionated and will install software and
# modify configuration files in your home directory. Review it carefully
# before running.

# --- Configuration ---
GIT_USER_NAME="Daniil Pankrashin"
GIT_USER_EMAIL="daniil@pankrashin.com"

# --- Colors for Output ---
COLOR_GREEN='\033[0;32m'
COLOR_YELLOW='\033[0;33m'
COLOR_BLUE='\033[0;34m'
COLOR_NC='\033[0m' # No Color

# --- Helper Functions ---
print_header() {
    echo -e "\n${COLOR_BLUE}+---------------------------------------------------------+${COLOR_NC}"
    echo -e "${COLOR_BLUE}|    $1${COLOR_NC}"
    echo -e "${COLOR_BLUE}+---------------------------------------------------------+${COLOR_NC}"
}

print_info() {
    echo -e "${COLOR_GREEN}INFO: $1${COLOR_NC}"
}

print_warn() {
    echo -e "${COLOR_YELLOW}WARN: $1${COLOR_NC}"
}

# --- Main Setup Functions ---

setup_terminal_and_cli() {
    print_header "Setting up Terminal & CLI"

    print_info "Disabling MOTD by creating .hushlogin file..."
    touch ~/.hushlogin

    print_info "Installing Oh-My-Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    print_info "Installing Starship shell prompt..."
    curl -sS https://starship.rs/install.sh | sh

    print_info "Adding Starship to .zshrc..."
    echo 'eval "$(starship init zsh)"' >> ~/.zshrc

    print_info "Configuring Git..."
    git config --global user.name "$GIT_USER_NAME"
    git config --global user.email "$GIT_USER_EMAIL"
    print_info "Git configured for '$GIT_USER_NAME <$GIT_USER_EMAIL>'"
}

install_homebrew_and_packages() {
    print_header "Installing Homebrew"

    if ! command -v brew &> /dev/null; then
        print_info "Homebrew not found. Installing..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        print_info "Homebrew is already installed. Updating..."
        brew update
    fi
    
    print_info "Homebrew to the current shell's PATH..."
    eval "$(/opt/homebrew/bin/brew shellenv)"


    # Install Brew CLI packages
    print_info "Installing CLI tools via Brew..."
    brew install fastfetch nvim bat fzf wget lazygit lima colima rbenv go imagemagick ffmpeg shntool ghostscript webp 

    # Install PHP stack
    print_info "Installing PHP stack via Brew..."
    brew install php
    brew install composer

    print_info "Adding Composer's bin to PATH in .zshrc"
    echo 'export PATH="$HOME/.composer/vendor/bin:$PATH"' >> ~/.zshrc

    print_info "Installing Laravel Installer globally..."
    composer global require laravel/installer
}

setup_vscode() {
    print_header "Setting up Visual Studio Code"

    print_info "Installing Visual Studio Code..."
    brew install --cask visual-studio-code

    print_info "Adding VS Code 'code' command to PATH in .zshrc..."
    cat << EOF >> ~/.zshrc
# Add Visual Studio Code (code)
export PATH="\$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
EOF

    export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
    
    # Check if `code` command is available before installing extensions
    if ! command -v code &> /dev/null; then
        print_warn "VS Code 'code' command not found. Skipping extension installation."
        print_warn "Please ensure VS Code is installed at the default location."
        return
    fi
    
    print_info "Installing VS Code extensions..."
    code --install-extension vscode-icons-team.vscode-icons      # vscode-icons
    code --install-extension tonybaloney.vscode-pets          # vscode-pets
    code --install-extension esbenp.prettier-vscode           # Prettier
    code --install-extension usernamehw.errorlens             # Error Lens
    code --install-extension ms-vscode.cpptools-extension-pack # C/C++ Extension Pack
    code --install-extension ms-python.python                 # Python
    code --install-extension ms-toolsai.jupyter              # Jupyter

    print_info "Setting VS Code as the default editor for common file types..."
    brew install duti python-yq
    curl -s "https://raw.githubusercontent.com/github/linguist/master/lib/linguist/languages.yml" \
      | yq -r "to_entries | (map(.value.extensions) | flatten) - [null] | unique | .[]" \
      | xargs -L 1 -I "{}" duti -s com.microsoft.VSCode {} all
}


# --- Script Execution ---
main() {
    setup_terminal_and_cli
    install_homebrew_and_packages
    setup_vscode

    print_header "Setup Complete!"
    print_info "Please restart your terminal or run 'source ~/.zshrc' for all changes to take effect."
}

main