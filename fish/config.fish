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

    # cd
    abbr -a cddesk 'cd ~/Desktop'
    abbr -a cddown 'cd ~/Downloads'
    abbr -a cddev 'cd ~/Developer'
    abbr -a cdproj 'cd ~/Developer/projects'
    abbr -a cdikat 'cd ~/Developer/ikat'
    abbr -a cdhda 'cd ~/Developer/h-da'

    # tools
    abbr --add '-' 'cd -'
    abbr --add 't' 'touch'
    abbr --add 'm' 'make'
    abbr --add 'j' 'just'
    abbr --add 'y' 'yarn'
    abbr --add 'cc' 'claude code'
    abbr --add 'cl' 'clear'
    abbr --add 'ff' 'fastfetch'
    abbr --add 'ls' 'eza -a -F -1 --group-directories-first --ignore-glob=".DS_Store"'
    abbr --add 'rm' 'rm -rf'
    abbr --add 'cat' 'bat'
    abbr --add 'vim' 'nvim'
    abbr --add 'lag' 'lazygit'
    abbr --add 'lad' 'lazydocker'
    abbr -a Y --position anywhere --set-cursor "%| pbcopy"
    abbr -a L --position anywhere --set-cursor "%| less -r"
    abbr -a F --position anywhere --set-cursor "%| fzf"

    # ssh
    abbr -a sshc 'nvim ~/.ssh/config'

    # nvim
    abbr -a vimc 'nvim ~/.config/nvim'

    # git
    abbr --add 'gs' 'git status'
    abbr --add 'grr' 'git rebase --continue'
    abbr --add 'gac' 'git add --all && git commit -m'
    abbr --add 'gap' 'git commit --amend --no-edit && git push --force-with-lease'
    abbr --add 'gaap' 'git add --all && git commit --amend --no-edit && git push --force-with-lease'
    abbr --add 'gtsnap' 'git diff --name-only | imfzf -m -q .png | xargs git checkout'
    abbr --add 'grim' 'git fetch && git rebase -i --autostash origin/(__git.default_branch)'
    abbr --add 'grac' 'git add --all && git rebase --continue' 
    abbr --add --position anywhere --set-cursor 'gbc' 'git branch --contains % | xargs git checkout'

    # php
    abbr --add 'a' 'php artisan'

    # nvm
    set --universal nvm_default_version lts
    set --universal nvm_default_packages yarn

    # python
    abbr --add 'p' 'python3'
    abbr --add 'pip' 'python3 -m pip'
    abbr --add 'cvenv' 'python3 -m venv .venv'
    abbr --add 'avenv' 'source .venv/bin/activate.fish'
    abbr --add 'dvenv' 'deactivate'

    # uv
    fish_add_path "/Users/daniil/.local/bin"
    abbr --add 'ui' 'uv init'
    abbr --add 'ur' 'uv run'
    abbr --add 'ua' 'uv add'
end
