function ssh --description "Use kitty ssh kitten when running ssh in kitty terminal"
    if test "$TERM" = xterm-kitty
        kitten ssh $argv
    else
        command ssh $argv
    end
end
