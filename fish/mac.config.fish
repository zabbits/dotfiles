if status is-interactive
    set EDITOR nvim
    fish_add_path /opt/homebrew/bin
    fish_add_path ~/.local/bin
    fish_add_path ~/.cargo/bin

    alias vi=nvim
    alias vim=nvim
    alias l='lsd -lah'
    alias ls=lsd

    fzf --fish | source
    zoxide init fish | source
    fnm env --use-on-cd | source
    atuin init fish | source
    starship init fish | source
    mise activate fish | source

    # Then use y instead of yazi to start, and press q to quit, you'll see the CWD changed. Sometimes, you don't want to change, press Q to quit.
    function y
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        yazi $argv --cwd-file="$tmp"
        if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
            builtin cd -- "$cwd"
        end
        rm -f -- "$tmp"
    end
end
