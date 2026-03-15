function nvim
    if set -q argv[1]
        command nvim $argv
    else
        command nvim .
    end
end
