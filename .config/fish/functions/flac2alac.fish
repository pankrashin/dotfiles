function flac2alac --desAcription "Convert all FLAC files in a folder to ALAC"
    if test (count $argv) -ne 1
        echo "Usage: flac2alac <folder>"
        return 1
    end

    set folder $argv[1]

    if not test -d "$folder"
        echo "Error: '$folder' is not a directory."
        return 1
    end

    for input in "$folder"/*.flac
        if not test -e "$input"
            continue
        end

        set output (path change-extension .m4a "$input")

        echo "Converting $input -> $output"
        ffmpeg -i "$input" -vn -c:a alac "$output"
    end
end
