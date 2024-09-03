export ZSH="$HOME/.oh-my-zsh"
plugins=(git)
source $ZSH/oh-my-zsh.sh

export EDITOR="nvim"

source /home/linuxbrew/.linuxbrew/share/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
source /home/linuxbrew/.linuxbrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /home/linuxbrew/.linuxbrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval "$(zoxide init zsh)"
eval $(thefuck --alias)
alias fk=fuck
source <(fzf --zsh)
#
# FZF Preview
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo $'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
  esac
}

# --- aliases
alias nv="nvim"
alias py="python3"
alias python="python3"
alias pyvenv="python3 -m venv .venv && source .venv/bin/activate"
alias f='open "$(fzf)"'
alias ls="eza --icons=always"
alias cd="z"
alias cat="bat"
alias so="source ~/.zshrc"

alias ga="git add"
alias gc="git commit"
alias gca="git commit --amend"
alias gl="git log"
alias gs="git status"
alias gd="git diff"
alias gp="git push"
alias gpl="git pull"
alias gf="git fetch"
