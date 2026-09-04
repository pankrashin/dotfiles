function update-all --description "Update all my stuff"

    echo "=== App Store ==="
    mas update
    mas reset

    echo "=== Homebrew ==="
    brew update
    brew upgrade --greedy -y
    brew autoremove
    brew cleanup --prune=all

    echo "=== Fisher ==="
    fisher update

    echo "=== uv ==="
    uv tool upgrade --all
    uv cache clean

    echo "=== npm ==="
    npm update -g
    npm cache clean --force

    echo "=== Done ==="
end
