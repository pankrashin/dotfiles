function fish_greeting
    echo -n "It's "
    set_color -o "5ef1ff"
    echo -n (date +%A)
    set_color normal
    echo -n ", the time is "
    set_color -o "f1ff5e"
    echo -n (date +%H:%M )
    set_color normal;
    echo ""
    echo -n "You are on "
    set_color -o "ffaecf"
    echo -n $hostname
    set_color normal
    echo ""
    echo ""

    set -l hood_color 5ea1ff
    set -l art \
        "                             .,,:'.                             " \
        "                          .cc:;c' .;:.                          " \
        "             .'.        ckxldl; .   .,ol.       .,'.            " \
        "          ,doc:oddl' .:c;oKOl::::,..    ',. .cldo::lx:          " \
        "         'k. .'....:;'ckx,      .   .  ....;:.'..'...dc         " \
        "         x,.   ..  .l0c.                 .cl    .    'O         " \
        "         o,.      ;d;       .,,,''''      .oK,      ..x         " \
        "          l'.    o: '   .'.'..........      'oc    .'l.         " \
        "           .;.  c.', .ckl,''.      .',,;,.    .;. .,.           " \
        "             .., ;.;xd:.                .,,;'.  ,..             " \
        "             o..;cd,     .....     ....     ':dc..l.            " \
        "            ;;,ko.     ';,cdd:,  .,odc;;;.     :k:.o            " \
        "            loO.     ..  .. .  ,,.   ..  .       :l;,           " \
        "           ok;      .,k'.,. .:0NXKx. .,'.dl..     .lO.          " \
        "          c0.     . ..,l'  cOxWNXW0kx  .l:.. .      :0          " \
        "         .d       ...   .. 000X0kKKkX, .   ...       'l         " \
        "         l         ...    ,Xd,:..,;;Nd    ...         l         " \
        "         c            .   oOd      c0k    .           ;         " \
        "         '.               kkl.    .:xK.               ;         " \
        "          c,              .l;..  ..,l.          .   .l          " \
        "       ,dx' ..  ..           ......           ..    . ;o,       " \
        "   .:xXxN.    ..  ....                      ....       lXXO:.   " \
        " .:c. O ,l .         .''.               ...'           oO, O;:, " \
        " .''. '   .             .,..        ...;.          .   o  . .'' " \
        "    .  .  .             ,        .''   ..         .   .    .    " \
        "                        o     ...      ;.            .          " \
        "                        o              :.                       " \
        "                        l              :.                       " \
        "                        ;              '                        " \
        "                        .              .                        "

    set -l color_ranges \
        "3 14 16" \
        "3 49 52" \
        "4 5 20" \
        "4 45 54" \
        "5 10 20" \
        "5 44 55" \
        "6 10 20" \
        "6 45 55" \
        "7 10 18" \
        "7 47 55" \
        "8 11 17" \
        "8 48 55" \
        "9 12 16" \
        "9 50 53" \
        "11 26 39" \
        "12 24 42" \
        "13 22 42" \
        "14 21 45" \
        "15 19 46" \
        "16 19 46" \
        "17 20 45" \
        "18 23 43" \
        "19 27 39" \
        "20 27 38" \
        "21 30 35"

    set -l r 0

    for line in $art
        set r (math "$r + 1")

        set -l ranges

        for range in $color_ranges
            set -l p (string split ' ' -- $range)

            if test $r -eq $p[1]
                set ranges $ranges "$p[2] $p[3]"
            end
        end

        if test (count $ranges) -eq 0
            set_color $hood_color
            echo -- $line
            set_color normal
            continue
        end

        set -l pos 1

        for range in $ranges
            set -l p (string split ' ' -- $range)
            set -l start $p[1]
            set -l stop $p[2]

            if test $start -gt $pos
                set_color $hood_color
                echo -n -- (string sub -s $pos -l (math "$start - $pos") -- $line)
            end

            set_color normal
            echo -n -- (string sub -s $start -l (math "$stop - $start + 1") -- $line)

            set pos (math "$stop + 1")
        end

        set -l len (string length -- $line)

        if test $pos -le $len
            set_color $hood_color
            echo -n -- (string sub -s $pos -- $line)
        end

        set_color normal
        echo
    end
end
