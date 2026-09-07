function update-all
    # app store apps
    mas update
    mas reset

    # homebrew packages
    brew update
    brew upgrade --greedy -y
    brew autoremove
    brew cleanup --prune=all

    # fish plugins
    fisher update

    # uv tools
    uv tool upgrade --all
    uv cache clean

    # npm global packages
    npm update -g
    npm cache clean --force

    # neovim plugins
    nvim --headless "+lua vim.pack.update(nil, { force = true })" +qa
end
