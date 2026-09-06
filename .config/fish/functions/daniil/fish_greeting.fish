function fish_greeting
    set -l weekday (date +%A)
    set -l time (date +%H:%M)

    printf "Welcome back, "
    set_color $fish_color_user
    printf "%s" $USER
    set_color normal
    printf "!\n\n"

    printf "Today is "
    set_color $fish_color_param
    printf "%s" $weekday
    set_color normal
    printf ", the time is "

    set_color $fish_color_option
    printf "%s" $time
    set_color normal
    printf "\nYou are on "

    set_color $fish_color_host
    printf "%s" $hostname
    set_color normal
    printf "\n\n"
end
