#!/bin/bash

# Function to install packages on macOS
install_macos() {
    echo "Installing packages on macOS..."
    # Check if Homebrew is installed, install if not
    if ! command -v brew &> /dev/null; then
        echo "Homebrew not found, installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    brew install fish fzf zoxide atuin starship lsd mise fd ripgrep zellij alacritty

    # Install Neovim nightly
    brew install --HEAD neovim

    # link config file
    mkdir -p ~/.config/fish
    mkdir -p ~/.config/alacritty
    ln -s ./starship.toml ~/.config/starship.toml
    ln -s ./nvim ~/.config/nvim
    ln -s ./fish/mac.config.fish ~/.config/fish/config.fish
    ln -s ./alacritty/mac.alacritty.toml ~/.config/alacritty/alacritty.toml
}

# Function to install packages on Ubuntu
install_ubuntu() {
    echo "Installing packages on Ubuntu..."
    sudo apt update
    sudo apt install -y software-properties-common
    sudo add-apt-repository ppa:neovim-ppa/unstable -y
    sudo apt update
    sudo apt install -y fish fzf lsd fd-find ripgrep neovim zellij alacritty

    # Install zoxide
    curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

    # Install atuin
    curl -sSL https://raw.githubusercontent.com/ellie/atuin/main/install.sh | sh

    # Install starship
    curl -sS https://starship.rs/install.sh | sh

    # Install mise
    curl https://mise.run | sh

    # link config file
    mkdir -p ~/.config/fish
    mkdir -p ~/.config/alacritty
    ln -s ./starship.toml ~/.config/starship.toml
    ln -s ./nvim ~/.config/nvim
    ln -s ./fish/config.fish ~/.config/fish/config.fish
    ln -s ./alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml
}

# Detect the operating system and install packages accordingly
if [[ "$OSTYPE" == "darwin"* ]]; then
    install_macos
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    install_ubuntu
else
    echo "Unsupported operating system: $OSTYPE"
    exit 1
fi

echo "Installation complete!"


