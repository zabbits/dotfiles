#!/bin/bash

install_pkgs() {
    echo "Installing packages ..."
    # Check if Homebrew is installed, install if not
    if ! command -v brew &> /dev/null; then
        echo "Homebrew not found, installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    brew install fish fzf zoxide atuin starship lsd mise fd ripgrep zellij alacritty

    # Install Neovim nightly
    brew install --HEAD neovim
}

install_pkgs()

echo "Installation complete!"


