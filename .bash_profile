# somehow, hyper minimal makes it not show the first line. they fixed it on open,  this kinda fixes it on cls
alias cls="clear && printf '\e[3J'"
alias vi="vim"
alias gitTree="git log --oneline --abbrev-commit --all --graph --decorate"
alias please='sudo $(fc -ln -1)'
alias startVim="cd ~/work/movercado3/ && vim draft_\"$(date '+%Y-%m-%d %H:%M')\""

function gitGrepOpen() { git grep -l "$@" | xargs -o vim; }
function gitGetFiles() { awk -F":" '{ print $1 }' | sort | uniq }
function gitOpenFiles() { awk -F":" '{ print $1 }' | sort | uniq | xargs vim }
function gitStatusOpenBothModified() { vim `git status | grep 'both modified' | awk '{print $3}'` }
function gitLogOpenLastFiles() { vim `git status --porcelain | awk '{print $2}'` }

function killGrep() { kill $(ps aux | grep -i "$@" | awk '{print $2}') }

function gitSizeObjects() {
  git ls-tree -rz --name-only HEAD -- | xargs -0 du -kh | sort -sh -k 1,1
}

ulimit -n 4096

export JAVA_HOME=$(/usr/libexec/java_home)
export PATH="$HOME/.cargo/bin:$PATH"

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
