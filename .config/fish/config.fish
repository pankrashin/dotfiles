if status is-interactive
    # color theme
    fish_config theme choose cyberdream

    # my custom functions
    set -p fish_function_path $__fish_config_dir/functions/daniil

    # dock size
    abbr -a dlock 'defaults write com.apple.dock size-immutable -bool true; killall Dock'
    abbr -a dunlock 'defaults write com.apple.dock size-immutable -bool false; killall Dock'

    # finder show hidden files
    abbr -a shidden 'defaults write com.apple.finder AppleShowAllFiles -bool true; killall Finder'
    abbr -a hhidden 'defaults write com.apple.finder AppleShowAllFiles -bool false; killall Finder'

    # finder enable quit option
    abbr -a fquit 'defaults write com.apple.finder QuitMenuItem -bool true; killall Finder'
    abbr -a funquit 'defaults write com.apple.finder QuitMenuItem -bool false; killall Finder'

    # gpu wired memory (42GB)
    abbr -a gwm 'sudo sysctl iogpu.wired_limit_mb=43008'

    # network
    abbr -a myip 'curl -s ipinfo.io | jq'
    abbr -a dspeed 'while true; iperf3 -c fra.speedtest.clouvider.net -p 5200-5209 -R; test $status -eq 0; and break; sleep 1; end'
    abbr -a uspeed 'while true; iperf3 -c fra.speedtest.clouvider.net -p 5200-5209; test $status -eq 0; and break; sleep 1; end'
    abbr -a hosts 'nvim /etc/hosts'

    # tailscale
    abbr -a tailscale '/Applications/Tailscale.app/Contents/MacOS/Tailscale'

    # LS_COLORS
    set -gx LS_COLORS (vivid generate cyberdream)

    # tide
    set -gx tide_pwd_color_anchors ffbd5e
    set -gx tide_pwd_color_dirs ffbd5e
    set -gx tide_pwd_color_truncated_dirs ffbd5e

    # tide git
    set -gx tide_git_icon 
    set -gx tide_git_color_branch ff6e5e
    set -gx tide_git_color_conflicted ff6e5e
    set -gx tide_git_color_dirty ffbd5e
    set -gx tide_git_color_operation 5ea1ff
    set -gx tide_git_color_staged 5eff6c
    set -gx tide_git_color_stash bd5eff
    set -gx tide_git_color_untracked ffaecf
    set -gx tide_git_color_upstream 5ef1ff

    # fzf.fish
    set -gx fzf_preview_dir_cmd eza -a1F -s=extension -I=.DS_Store --group-directories-first --color=always --icons=always
    set -gx fzf_preview_file_cmd bat -f --style=changes,grid,header-filename,header-filesize,numbers,snip
    set -gx fzf_fd_opts -H -E .DS_Store -E .git
    set -gx fzf_git_log_format '%C(bold #f1ff5e)%h%C(reset) %C(#5ea1ff)%ad%C(reset) %C(#bd5eff)%d%C(reset) %C(#ffffff)%s%C(reset) %C(#7b8496)[%an]%C(reset)'
    set -gx fzf_diff_highlighter delta --paging=never --width=20
    set -gx fzf_history_time_format %d %b %y %H:%M:%S
    set -gx FZF_DEFAULT_OPTS "\
        --color=fg:#ffffff,fg+:#ffffff,bg:#16181a,bg+:#3c4048 \
        --color=hl:#5ef1ff,hl+:#5ef1ff,info:#7b8496,marker:#5eff6c \
        --color=prompt:#ffbd5e,spinner:#bd5eff,pointer:#ffaecf,header:#5ef5d2 \
        --color=border:#3c4048,label:#ffbd5e,query:#ffffff \
        --border=rounded --border-label=fzf --border-label-pos=0 --preview-window=border-rounded \
        --prompt='> ' --marker='>' --pointer='◆' --separator='─' \
        --scrollbar='│' --layout=reverse --info=right"

    # change sorting in fzf.fish fd
    if functions --query _fzf_search_directory
        functions _fzf_search_directory \
            | string replace --all -- '| _fzf_wrapper' '| sort | _fzf_wrapper' \
            | source
    end

    # change date format in fzf.fish git logs
    if functions --query _fzf_search_git_log
        functions _fzf_search_git_log \
            | string replace -- '--date=short' '--date="format:%d %b %Y"' \
            | source
    end

    # fzf.fish keymaps
    fzf_configure_bindings \
        --directory=super-d \
        --git_log=super-l \
        --git_status=super-g \
        --history=super-i \
        --processes=super-p \
        --variables=super-e

    # nvm.fish
    set -gx nvm_default_version lts
    set -gx nvm_default_packages pnpm

    # done
    set -gx __done_min_cmd_duration 10000

    # fish_title
    set -gx fish_title_no_pwd man less caffeinate btop ctop lazydocker mo meridian

    # cd
    abbr -a - 'cd -'
    abbr -a .. 'cd ..'
    abbr -a ... 'cd ../..'
    abbr -a .... 'cd ../../..'
    abbr -a ..... 'cd ../../../..'
    abbr -a cdconf 'cd ~/.config'
    abbr -a cdkitty 'cd ~/.config/kitty'
    abbr -a cdfish 'cd ~/.config/fish'
    abbr -a cdnvim 'cd ~/.config/nvim'
    abbr -a cddesk 'cd ~/Desktop'
    abbr -a cddown 'cd ~/Downloads'
    abbr -a cddev 'cd ~/Developer'
    abbr -a cdikat 'cd ~/Developer/ikat'
    abbr -a cdshop 'cd ~/Developer/futtershop'

    # configs
    abbr -a configs 'nvim ~/.config'
    abbr -a kittyc 'nvim ~/.config/kitty/kitty.conf'
    abbr -a fishc 'nvim ~/.config/fish/config.fish'
    abbr -a nvimc 'nvim ~/.config/nvim/init.lua'

    # tools
    abbr -a o 'open'
    abbr -a t 'touch'
    abbr -a m 'make'
    abbr -a j 'just'
    abbr -a y 'yazi'
    abbr -a mv 'mv -v'
    abbr -a cp 'cp -v'
    abbr -a rm 'rm -rf -v'
    abbr -a cl 'clear'
    abbr -a ff 'fastfetch'
    abbr -a vi 'nvim'
    abbr -a vim 'nvim'
    abbr -a lag 'lazygit'
    abbr -a lad 'lazydocker'
    abbr -a diff 'nvim -d'
    abbr -a chmox 'chmod +x'
    abbr -a where 'which'
    abbr -a G --position anywhere '| grep'
    abbr -a C --position anywhere --set-cursor '%| pbcopy'
    abbr -a L --position anywhere --set-cursor '%| less -r'
    abbr -a F --position anywhere --set-cursor '%| fzf'

    # kittens
    abbr -a ki 'kitten icat'
    abbr -a kt 'kitten transfer'
    abbr -a kc 'kitten clipboard'

    # ssh
    abbr -a sshc 'nvim ~/.ssh/config'
    abbr -a sshl 'ssh-add -L'
    abbr -a ssha --set-cursor 'ssh-add --apple-use-keychain ~/.ssh/keys/%'

    # scp
    abbr -a scpuf --set-cursor 'scp % user@server:/path/on/remote/'
    abbr -a scpud --set-cursor 'scp -r % user@server:/path/on/remote/'
    abbr -a scpdf --set-cursor 'scp user@server:% /path/on/local/'
    abbr -a scpdd --set-cursor 'scp -r user@server:% /path/on/local/'

    # eza
    alias ls='eza -1 -F=auto -s=extension -I=.DS_Store --group-directories-first --color=auto --icons=auto'
    alias la='eza -a1 -F=auto -s=extension -I=.DS_Store --group-directories-first --color=auto --icons=auto'
    alias ll='eza -loh -F=auto -s=extension -I=.DS_Store --group-directories-first --no-permissions --git --color=auto --icons=auto'
    alias lla='eza -aloh -F=auto -s=extension -I=.DS_Store --group-directories-first --no-permissions --git --color=auto --icons=auto'
    alias lt='eza -T -F=auto -s=extension -I=.DS_Store --group-directories-first --color=auto --icons=auto'

    # bat
    alias cat='bat --style=changes,grid,header-filename,header-filesize,numbers,snip --paging=never'
    alias cap='bat -p --paging=never'

    # git
    abbr -a gs 'git status'
    abbr -a grr 'git rebase --continue'
    abbr -a gac 'git add --all && git commit -m'
    abbr -a gap 'git commit --amend --no-edit && git push --force-with-lease'
    abbr -a gaap 'git add --all && git commit --amend --no-edit && git push --force-with-lease'
    abbr -a gacdp 'git add --all && git commit -m $(date) && git push'
    abbr -a gtsnap 'git diff --name-only | imfzf -m -q .png | xargs git checkout'
    abbr -a grim 'git fetch && git rebase -i --autostash origin/(__git.default_branch)'
    abbr -a grac 'git add --all && git rebase --continue'
    abbr -a gbc --position anywhere --set-cursor 'git branch --contains % | xargs git checkout'

    # yadm
    abbr -a ys 'yadm status'
    abbr -a yp 'yadm push'
    abbr -a yau 'yadm add -u'
    abbr -a ycd 'yadm commit -m $(date)'

    # laravel
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
    fish_add_path ~/.local/bin
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

    # hugging face
    abbr -a hfd 'hf download'
    abbr -a hfcl 'hf cache ls'
    abbr -a hfcr 'hf cache rm'

    # claude
    abbr -a c 'claude'
    abbr -a cc 'claude --continue'
    abbr -a cr 'claude --resume'

    # pi
    abbr -a pis 'pi --session'

    # agentsview
    abbr -a av 'agentsview serve &; open http://localhost:8080'

    # firecrawl
    set -gx FIRECRAWL_API_URL 'http://localhost:3002'
    set -gx FIRECRAWL_API_KEY 'firecrawl'

    # zoxide
    zoxide init fish | source
end
