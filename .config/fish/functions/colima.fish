function colima --wraps colima --description 'colima, launching ColimaBar on start/restart'
    command colima $argv
    set -l status_code $status

    # Only surface the menubar widget for commands that bring an instance up,
    # and only if colima itself succeeded.
    if test $status_code -eq 0
        switch "$argv[1]"
            case start restart
                if not pgrep -qf '/Applications/ColimaBar.app/Contents/MacOS/ColimaBar'
                    # -g: do not steal focus from the terminal.
                    open -g -b com.colimabar.app 2>/dev/null
                end
        end
    end

    return $status_code
end
