function ssh --description "Use kitty's SSH kitten when running in kitty terminal"
    if test "$TERM" = xterm-kitty
        kitten ssh $argv
    else
        command ssh $argv
    end
end
