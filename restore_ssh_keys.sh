#!/bin/bash
set -e

SSH_DIR="$HOME/.ssh"

mkdir -p "$SSH_DIR"
chmod 700 "$SSH_DIR"

FILES=("./vault/id_ed25519" "./vault/id_ed25519.pub")

for file in "${FILES[@]}"; do
    if [ -f "$file" ]; then
        echo "Copiando '$file' para '$SSH_DIR/'..."
        cp "$file" "$SSH_DIR/"
    else
        echo "Arquivo '$file' não encontrado no diretório atual!"
        exit 1
    fi
done

cd "$SSH_DIR"

echo "Descriptografando arquivos..."
ansible-vault decrypt "id_ed25519" "id_ed25519.pub"

chmod 600 id_ed25519
chmod 644 id_ed25519.pub

echo "Chaves restauradas e configuradas com sucesso!"
