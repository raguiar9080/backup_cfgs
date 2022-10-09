# stuff
alias cls="clear && printf '\e[3J'"
alias vi="vim"
alias startVim="cd ~/work/lune && vim draft_\"$(date '+%Y-%m-%d %H:%M')\""
alias please='sudo $(fc -ln -1)'
alias dockerClean='docker system prune'
function vanillaVim() { vim -u ~/.vanilla_vimrc $@ }
function killGrep() { kill $(ps aux | grep -i "$@" | awk '{print $2}') }

# git stuff
alias gitTree="git log --oneline --abbrev-commit --all --graph --decorate"
function gitGrepOpen() { git grep -l "$@" | xargs -o vim; }
function gitGetFiles() { awk -F":" '{ print $1 }' | sort | uniq }
function gitOpenFiles() { awk -F":" '{ print $1 }' | sort | uniq | xargs vim }
function gitStatusOpenBothModified() { vim `git status | grep 'both modified' | awk '{print $3}'` }
function gitLogOpenLastFiles() { vim `git status --porcelain | awk '{print $2}'` }
function gitOpenDiffFiles() { vim `git status | grep modified | awk '{print $2}'` }
function gitSizeObjects() {
  git ls-tree -rz --name-only HEAD -- | xargs -0 du -kh | sort -sh -k 1,1
}

# work related local stuff
alias attachBackend="cd ~/work/lune/lune-backend && docker compose exec backend /bin/bash"
alias attachDB="cd ~/work/lune/lune-backend && docker compose exec db /bin/bash"
alias buildTSClient="docker-compose -f docker-compose-ci.yml run update_from_remote_schema"
function OPENAPI_GENERATOR_OFFLINE_BUILD() { cls && yarn build && node bin/index.js -i final-schema.yml --output client --exportCore false --exportServices true --exportSchemas false }

# work related prod/preprod stuff
function PROD_ATTACH_DB() { kubectl exec -n lune -it $(kubectl get pods -n lune | rg webhook-daemon | cut -d ' ' -f 1) -- lune dbshell /etc/lune/prod.json }
function PROD_ATTACH_BASH() { kubectl get pods -n lune --selector=app=admin -o=name | head -n 1 | xargs -o -I {} kubectl -n lune exec -ti {} -- bash }
function PREPROD_ATTACH_DB() { kubectl exec -n lune -it $(kubectl get pods -n lune | rg webhook-daemon | cut -d ' ' -f 1) -- lune dbshell /etc/lune/preprod.json }
function PREPROD_ATTACH_BASH() { kubectl get pods -n lune --selector=app=admin -o=name | head -n 1 | xargs -o -I {} kubectl -n lune exec -ti {} -- bash }

# Configurations
ulimit -n 4096

export JAVA_HOME=$(/usr/libexec/java_home)
export PATH=$JAVA_HOME/bin:$PATH

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
. "$HOME/.cargo/env"

export PATH="$HOME/.poetry/bin:$PATH"
