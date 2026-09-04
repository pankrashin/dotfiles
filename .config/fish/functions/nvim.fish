function nvim --description "Open neovim in current working directory when no arguments passed"
    if set -q argv[1]
        command nvim $argv
    else
        command nvim .
    end
end
