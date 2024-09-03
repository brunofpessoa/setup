#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Execute este script com sudo."
    exit 1
fi

sudo apt update -y &&
sudo apt install keepassxc kopia kopia-ui -y &&

# --- homebrew ---
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" &&

# --- ohmyzsh ---
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" &&

brew install curl jq zsh zsh-autosuggestions zsh-syntax-highlighting eza zoxide git go luarocks lazygit node neovim ripgrep xclip syncthing fzf powerlevel10k yazi nvm &&

echo -e "\nInstalação de aplicativos finalizada!\n"

echo -e "\nCriado links simbólicos de configurações...\n"

# --- zshrc
if [[ -f "$HOME/.zshrc" ]]; then
    mv "$HOME/.zshrc" "$HOME/.zshrc.pre-setup"
fi
ln -s "./zshrc" "$HOME/.zshrc"

# --- powerlevel10k
if [[ -f "$HOME/.p10k.zsh" ]]; then
    mv "$HOME/.p10k.zsh" "$HOME/.p10k.pre-setup.zsh"
fi
ln -s "./p10k.zsh" "$HOME/.p10k.zsh"

# --- wezterm
if [[ -f "$HOME/.config/wezterm/wezterm.lua" ]]; then
    mv "$HOME/.config/wezterm/wezterm.lua" "$HOME/.config/wezterm/wezterm.pre-setup.lua"
else
    mkdir -p "$HOME/.config/wezterm"
fi
ln -s "./wezterm.lua" "$HOME/.config/wezterm/wezterm.lua"

echo -e "\nLinks criados com sucesso!\n"

read -p "Deseja executar 'apt upgrade' agora? (S/N): " confirm && [[ $confirm == [sS] || $confirm == [yY] ]] || exit 0

sudo apt upgrade -y
