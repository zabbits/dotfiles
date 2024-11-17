if status is-interactive
    # Commands to run in interactive sessions can go here
    alias vi=nvim
    alias vim=nvim
    alias l='lsd -lah'
    alias ls=lsd
    alias hx=helix

    zoxide init fish | source
    atuin init fish | source
    starship init fish | source
end
