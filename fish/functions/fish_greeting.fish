function fish_greeting
    echo -n "It's "; set_color -o "#5eff6c"; echo -n (date +%A); set_color normal; echo -n " my dudes 🐸 and the time is "; set_color -o "#f1ff5e"; echo -n (date +%H:%M ); set_color normal;
    echo ""
    echo -n "You are on "; set_color -o "#ffbd5e"; echo -n $hostname; set_color normal;  echo " btw"; 
    echo ""
end
