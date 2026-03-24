function nvim --description "Open neovim in current directory when no arguments given"
    if set -q argv[1]
        command nvim $argv
    else
        command nvim .
    end
end
