if status is-interactive
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
end
