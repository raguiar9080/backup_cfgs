# somehow, hyper minimal makes it not show the first line. they fixed it on open,  this kinda fixes it on cls
alias cls="clear && printf '\e[3J'"
alias vi="vim"
alias gittree="git log --oneline --abbrev-commit --all --graph --decorate"
alias please='sudo $(fc -ln -1)'

function gitgrepopen() { git grep -l "$@" | xargs -o vim; }
function gitgetfiles() { awk -F":" '{ print $1 }' | sort | uniq }
function gitopenfiles() { awk -F":" '{ print $1 }' | sort | uniq | xargs vim }
function gitstatusopenbothmodified() { vim `git status | grep 'both modified' | awk '{print $3}'` }
function gitlogopenlastfiles() { vim `git status --porcelain | awk '{print $2}'` }

ulimit -n 4096

export JAVA_HOME=$(/usr/libexec/java_home)
export PATH="$HOME/.cargo/bin:$PATH"
