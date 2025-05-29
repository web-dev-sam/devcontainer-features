#!/bin/sh
set -e

echo "Activating feature 'common-alpine'"

apk add --no-cache bash bash-completion git openssh starship

cat >> ~/.bashrc << 'EOF'
alias c='clear'
alias ls='ls --color=auto'
alias l='ls -A'
alias ll='ls -la'
alias doch='sudo "$BASH" -c "$(history -p !!)"'
alias g='git'
alias gs='git status'
alias gf='git fetch --all'
alias gp='git pull'
alias gb='git branch -a'
alias gc='git checkout'
alias gcb='git checkout -b'
alias gcm='git checkout main'
alias gcd='git checkout dev'
alias gl='git log --oneline --graph'

eval "$(starship init bash)"
EOF

echo 'Done!'

# These following environment variables are passed in by the dev container CLI.
# These may be useful in instances where the context of the final 
# remoteUser or containerUser is useful.
# For more details, see https://containers.dev/implementors/features#user-env-var
#
# echo "The effective dev container remoteUser is '$_REMOTE_USER'"
# echo "The effective dev container remoteUser's home directory is '$_REMOTE_USER_HOME'"
# echo "The effective dev container containerUser is '$_CONTAINER_USER'"
# echo "The effective dev container containerUser's home directory is '$_CONTAINER_USER_HOME'"