# function fish_greeting
#     echo -n "It's "; set_color $fish_color_param; echo -n (date +%A); set_color normal; echo -n ", the time is "; set_color $fish_color_option; echo -n (date +%H:%M )
#     set_color normal; echo ""; echo -n "You are on "; set_color $fish_color_command; echo -n $hostname
#     echo ""
#     echo ""
# end

function fish_greeting
    echo -n "Welcome back, "; set_color $fish_color_cwd; echo -n $USER; set_color normal; echo -n "!";
    echo ""
    echo ""
    echo -n "Today is "; set_color $fish_color_param; echo -n (date +%A); set_color normal; echo -n ", the time is "; set_color $fish_color_keyword; echo -n (date +%H:%M )
    set_color normal; echo ""; echo -n "You are on "; set_color $fish_color_command; echo -n $hostname

    echo ""
    echo ""
end
