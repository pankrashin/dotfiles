if status is-interactive
    # fish
    abbr -a fishc 'fish_config'
    
    # tide
    set -U tide_git_icon ''
    set -U tide_git_color_branch ff6e5e
    set -U tide_git_color_conflicted ff6e5e
    set -U tide_git_color_dirty ffbd5e
    set -U tide_git_color_operation ff5ea0
    set -U tide_git_color_staged 5eff6c
    set -U tide_git_color_stash bd5eff
    set -U tide_git_color_untracked 7b8496
    set -U tide_git_color_upstream 5ef1ff

    # fzf
    fzf_configure_bindings --directory=super-f \
                           --git_log=super-l \
                           --git_status=super-s \
                           --history=super-i \
                           --processes=super-p \
                           --variables=super-e

    # nvm
    set -U nvm_default_version lts
    set -U nvm_default_packages yarn

    # cd
    abbr -a 'cddesk' 'cd ~/Desktop'
    abbr -a 'cddev' 'cd ~/Developer'
    abbr -a 'cddown' 'cd ~/Downloads'
    abbr -a 'cdikat' 'cd ~/Developer/ikat'
    abbr -a 'cdhda' 'cd ~/Developer/h-da'

    # tools
    abbr -a '-' 'cd -'
    abbr -a 't' 'touch'
    abbr -a 'm' 'make'
    abbr -a 'j' 'just'
    abbr -a 'y' 'yarn'
    abbr -a 'cc' 'claude code'
    abbr -a 'cl' 'clear'
    abbr -a 'ff' 'fastfetch'
    abbr -a 'ls' 'eza -a -F -1 --group-directories-first --ignore-glob=".DS_Store"'
    abbr -a 'rm' 'rm -rf'
    abbr -a 'cat' 'bat'
    abbr -a 'vim' 'nvim'
    abbr -a 'lag' 'lazygit'
    abbr -a 'lad' 'lazydocker'
    abbr -a 'configs' 'nvim ~/.config'
    abbr -a 'Y' --position anywhere --set-cursor '%| pbcopy'
    abbr -a 'L' --position anywhere --set-cursor '%| less -r'
    abbr -a 'F' --position anywhere --set-cursor '%| fzf'

    # ssh
    abbr -a 'sshc' 'nvim ~/.ssh/config'

    # nvim
    abbr -a 'vimc' 'nvim ~/.config/nvim'

    # git
    abbr -a 'gs' 'git status'
    abbr -a 'grr' 'git rebase --continue'
    abbr -a 'gac' 'git add --all && git commit -m'
    abbr -a 'gap' 'git commit --amend --no-edit && git push --force-with-lease'
    abbr -a 'gaap' 'git add --all && git commit --amend --no-edit && git push --force-with-lease'
    abbr -a 'gtsnap' 'git diff --name-only | imfzf -m -q .png | xargs git checkout'
    abbr -a 'grim' 'git fetch && git rebase -i --autostash origin/(__git.default_branch)'
    abbr -a 'grac' 'git add --all && git rebase --continue'
    abbr -a 'gbc' --position anywhere --set-cursor 'git branch --contains % | xargs git checkout'

    # php
    abbr -a 'a' 'php artisan'

    # python
    abbr -a 'p' 'python3'
    abbr -a 'pip' 'python3 -m pip'
    abbr -a 'cvenv' 'python3 -m venv .venv'
    abbr -a 'avenv' 'source .venv/bin/activate.fish'
    abbr -a 'dvenv' 'deactivate'

    # uv
    fish_add_path '/Users/daniil/.local/bin'
    abbr -a 'ui' 'uv init'
    abbr -a 'ur' 'uv run'
    abbr -a 'ua' 'uv add'
end
