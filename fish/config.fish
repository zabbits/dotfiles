if status is-interactive
    # Commands to run in interactive sessions can go here
    alias vi=nvim
    alias vim=nvim
    alias ls='exa --color=always --icons=always'
    alias hx=helix

    fzf --fish | source
    zoxide init fish | source
    atuin init fish | source
    starship init fish | source
    mise activate fish | source
end
