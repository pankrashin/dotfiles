function fish_title
    # If we're connected via ssh, we print the hostname.
    set -l ssh
    set -q SSH_TTY
    and set ssh "["(prompt_hostname | string sub -l 10 | string collect)"]"

    # An override for the current command is passed as the first parameter.
    # This is used by `fg` to show the true process name, among others.
    set -l command

    if set -q argv[1]
        set command $argv[1]
    else
        # Don't print "fish" because it's redundant
        set command (status current-command)
        if test "$command" = fish
            set command
        end
    end

    # Don't print pwd for commands in fish_title_no_pwd (check by basename)
    for token in (string split -n -- " " $command | path basename)
        contains -- $token $fish_title_no_pwd
        and echo -- $ssh (string sub -l 20 -- $command)
        and return
    end

    echo -- $ssh (string sub -l 20 -- $command) (prompt_pwd -d 1 -D 1)
end



# Defined in /usr/share/fish/functions/fish_title.fish @ line 1
function fish_title
    # If we're connected via ssh, we print the hostname.
    set -l ssh
    set -q SSH_TTY
    and set ssh "["(prompt_hostname | string sub -l 10 | string collect)"]"
    # An override for the current command is passed as the first parameter.
    # This is used by `fg` to show the true process name, among others.
    if set -q argv[1]
        echo -- $ssh (string sub -l 20 -- $argv[1]) (prompt_pwd -d 1 -D 1)
    else
        # Don't print "fish" because it's redundant
        set -l command (status current-command)
        if test "$command" = fish
            set command
        end
        echo -- $ssh (string sub -l 20 -- $command) (prompt_pwd -d 1 -D 1)
    end
end
