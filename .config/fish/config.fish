if status is-interactive
    # macos dock
    abbr -a dlock 'defaults write com.apple.dock size-immutable -bool true; killall Dock'
    abbr -a dunlock 'defaults write com.apple.dock size-immutable -bool false; killall Dock'

    set fish_cursor_default block

    # finder
    abbr -a shidden 'defaults write com.apple.finder AppleShowAllFiles -bool true; killall Finder;'
    abbr -a hhidden 'defaults write com.apple.finder AppleShowAllFiles -bool false; killall Finder;'

    # gpu wired memory (40GB)
    abbr -a gwm 'sudo sysctl iogpu.wired_limit_mb=40960'

    # homebrew
    /opt/homebrew/bin/brew shellenv | source

    # pipx
    fish_add_path -g ~/.local/bin

    #pyenv
    set -gx PYENV_ROOT $HOME/.pyenv
    fish_add_path -g $PYENV_ROOT/bin
    pyenv init - fish | source

    #lm studio
    fish_add_path -g ~/.lmstudio/bin

    # xdg base directories
    set -gx XDG_CONFIG_HOME $HOME/.config

    # tide
    # match pwd colors with cyberdream theme
    set -gx tide_pwd_color_anchors ffbd5e
    set -gx tide_pwd_color_dirs ffbd5e
    set -gx tide_pwd_color_truncated_dirs ffbd5e
    # git
    set -gx tide_git_icon 
    set -gx tide_git_color_branch ff6e5e
    set -gx tide_git_color_conflicted ff6e5e
    set -gx tide_git_color_dirty ffbd5e
    set -gx tide_git_color_operation ff5ea0
    set -gx tide_git_color_staged 5eff6c
    set -gx tide_git_color_stash bd5eff
    set -gx tide_git_color_untracked 7b8496
    set -gx tide_git_color_upstream 5ef1ff

    # fzf.fish
    fzf_configure_bindings --directory=super-f \
                           --git_log=super-l \
                           --git_status=super-s \
                           --history=super-i \
                           --processes=super-p \
                           --variables=super-e

    # nvm.fish
    set -gx nvm_default_version lts
    set -gx nvm_default_packages yarn pnpm

    # done
    set -g __done_min_cmd_duration 10000

    # kitty kittens
    abbr -a ki 'kitten icat'
    abbr -a kt 'kitten transfer'
    abbr -a kc 'kitten clipboard'

    # cd
    abbr -a cddesk 'cd ~/Desktop'
    abbr -a cddev 'cd ~/Developer'
    abbr -a cdikat 'cd ~/Developer/ikat'
    abbr -a cdhda 'cd ~/Developer/h-da'
    abbr -a cddown 'cd ~/Downloads'

    # tools
    abbr -a - 'cd -'
    abbr -a t 'touch'
    abbr -a m 'make'
    abbr -a j 'just'
    abbr -a y 'yarn'
    abbr -a cc 'claude'
    abbr -a cl 'clear'
    abbr -a ff 'fastfetch'
    abbr -a rm 'rm -rf'
    abbr -a ip 'curl -s ipinfo.io | jq '
    abbr -a cat 'bat'
    abbr -a vim 'nvim'
    abbr -a lag 'lazygit'
    abbr -a lad 'lazydocker'
    abbr -a diff 'nvim -d'
    abbr -a Y --position anywhere --set-cursor '%| pbcopy'
    abbr -a L --position anywhere --set-cursor '%| less -r'
    abbr -a F --position anywhere --set-cursor '%| fzf'

    # configs
    abbr -a configs 'nvim ~/.config'
    abbr -a fishc 'nvim ~/.config/fish/config.fish'
    abbr -a vimc 'nvim ~/.config/nvim/init.lua'
    abbr -a sshc 'nvim ~/.ssh/config'
    abbr -a hosts 'nvim /etc/hosts'
    
    # lsd
    abbr -a ls 'lsd -1'
    abbr -a la 'lsd -1A'
    abbr -a l 'lsd -l'
    abbr -a lla 'lsd -lA'
    abbr -a lt 'lsd --tree'
    abbr -a lta 'lsd --tree -a'

    # git
    abbr -a gs 'git status'
    abbr -a grr 'git rebase --continue'
    abbr -a gac 'git add --all && git commit -m'
    abbr -a gap 'git commit --amend --no-edit && git push --force-with-lease'
    abbr -a gaap 'git add --all && git commit --amend --no-edit && git push --force-with-lease'
    abbr -a gacdp 'git add --all && git commit -m "$(date)" && git push'
    abbr -a gtsnap 'git diff --name-only | imfzf -m -q .png | xargs git checkout'
    abbr -a grim 'git fetch && git rebase -i --autostash origin/(__git.default_branch)'
    abbr -a grac 'git add --all && git rebase --continue'
    abbr -a gbc --position anywhere --set-cursor 'git branch --contains % | xargs git checkout'

    # php
    abbr -a a 'php artisan'
    abbr -a aoc 'php artisan optimize:clear'

    # python
    abbr -a p 'python'
    abbr -a pv 'python --version'
    abbr -a pip 'python -m pip'
    abbr -a cvenv 'python -m venv .venv'
    abbr -a avenv 'source .venv/bin/activate.fish'
    abbr -a dvenv 'deactivate'

    # uv
    abbr -a ui 'uv init'
    abbr -a ur 'uv run'
    abbr -a ua 'uv add'

    # jupyter
    abbr -a jn 'jupyter notebook'
    abbr -a jl 'jupyter lab'
    abbr -a pipjn 'python -m pip install notebook'
    abbr -a pipjl 'python -m pip install jupyterlab'
    abbr -a uajn 'uv add notebook'
    abbr -a uajl 'uv add jupyterlab'

    # maya
    abbr -a maya 'open /Users/daniil/Library/Preferences/Autodesk/maya/'
end
