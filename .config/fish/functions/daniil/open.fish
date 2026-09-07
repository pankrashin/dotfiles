function open
    if set -q argv[1]
        command open $argv
    else
        command open .
    end
end

