if status is-interactive
    fish_add_path /opt/homebrew/bin

    # Commands to run in interactive sessions can go here
    alias vi=nvim
    alias vim=nvim
    alias l='lsd -lah'
    alias ls=lsd
    alias hx=helix

    fzf --fish | source
    zoxide init fish | source
    fnm env --use-on-cd | source
    atuin init fish | source
    starship init fish | source
end
