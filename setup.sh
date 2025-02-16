#!/bin/bash

if [ "$EUID" -eq 0 ]; then
    echo "Este script não deve ser executado com sudo."
    exit 1
fi

read -p "Deseja restaurar as chaves SSH? (S/N): " restore_ssh
read -p "Deseja criar os diretórios ~/projetos e ~/notas? (S/N): " create_dirs
read -p "Instalar Node LTS? (S/N): " install_node_lts
read -p "Deseja executar 'apt upgrade'? (S/N): " do_apt_upgrade
read -p "Instalar fonte CascadiaCode Nerd Font? (S/N): " install_nerd_font
read -p "Instalar Catppuccin para o Gnome Terminal? (S/N): " install_catppuccin

if [[ "$restore_ssh" =~ ^[YySs]$ ]]; then
    ./restore_ssh_keys.sh
fi

echo "Atualizando repositórios..."
sudo apt update

echo "Instalando pacotes..."
sudo apt install curl gnome-tweaks gnome-shell-extensions ansible zsh unzip python3 build-essential -y

echo "Instalando Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

echo "Instalando pacotes com o Homebrew..."
brew install tmux git jq xclip nvm zsh-autosuggestions zsh-syntax-highlighting eza bat zoxide go luarocks lazygit neovim ripgrep fzf powerlevel10k

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
sudo cp ./bin/tmuxer /usr/local/bin

mkdir ~/.nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh" ] && \. "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh"

if [[ "$install_node_lts" =~ ^[YySs]$ ]]; then
    nvm use node --lts
fi

if [[ "$create_dirs" =~ ^[YySs]$ ]]; then
    echo "Criando diretórios na home do usuário..."
    mkdir -p ~/projetos
    mkdir -p ~/notas
    echo "Diretórios criados."
fi

if [[ "$install_nerd_font" =~ ^[YsSs]$ ]]; then
    mkdir -p ~/.fonts
    curl -L https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/CascadiaCode.zip -o /tmp/CascadiaCode.zip && unzip /tmp/CascadiaCode.zip -d ~/.fonts/CascadiaCode && rm /tmp/CascadiaCode.zip
fi

if [[ "$install_catppuccin" =~ ^[YsSs]$ ]]; then
    curl -L https://raw.githubusercontent.com/catppuccin/gnome-terminal/v1.0.0/install.py | python3 -
fi

if [[ "$do_apt_upgrade" =~ ^[YySs]$ ]]; then
    sudo apt upgrade -y
fi

echo "Instalando Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Copiando arquivos de configuração..."
[ -e ./p10k.zsh ] && cp ./p10k.zsh ~/.p10k.zsh
[ -e ./zshrc ] && cp ./zshrc ~/.zshrc
[ -e ./tmux.conf ] && cp ./tmux.conf ~/.tmux.conf

echo -e "\n============\nObservações:\n============"
echo "1. Para aplicar as alterações do shell reinicie a sessão."
echo "2. Para instalar os plugins do Tmux use 'Prefix+I'."

