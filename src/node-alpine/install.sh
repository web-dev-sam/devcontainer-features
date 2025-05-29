#!/bin/sh
set -e

echo "Activating feature 'node-alpine'"

apk add --no-cache "nodejs=~22" npm
npm i -g npm@latest @antfu/ni@${NIVERSION}

if [ "$PACKMAN" = "pnpm" ]; then
    export PNPM_HOME="/root/.local/share/pnpm"
    mkdir -p "$PNPM_HOME"
    apk add --no-cache pnpm
    echo 'export PNPM_HOME="/root/.local/share/pnpm"' >> /etc/profile.d/pnpm.sh
    echo 'export PATH="$PNPM_HOME:$PATH"' >> /etc/profile.d/pnpm.sh
    chmod +x /etc/profile.d/pnpm.sh
    echo 'export PNPM_HOME="/root/.local/share/pnpm"' >> /root/.bashrc
    echo 'export PATH="$PNPM_HOME:$PATH"' >> /root/.bashrc
    export PATH="$PNPM_HOME:$PATH"
fi

cat >> ~/.bashrc << 'EOF'

alias i='ni'
alias ui='nun'
alias dev='nr dev'
alias build='nr build'

alias x='nlx'
alias pretty='nlx pretty-quick --check'
alias pretty-write='nlx pretty-quick'
alias mit='nlx mit-license --name "YOUR NAME" --output LICENSE.md'
alias newer='nlx npm-upgrade'
alias types='nlx typesync'
alias killnode='nlx npkill --sort "size"'

###-begin-nr-completion-###
if type complete &>/dev/null; then
  _nr_completion() {
    local words
    local cur
    local cword
    _get_comp_words_by_ref -n =: cur words cword
    IFS=$'\n'
    COMPREPLY=($(COMP_CWORD=$cword COMP_LINE=$cur nr --completion ${words[@]}))
  }
  complete -F _nr_completion nr
fi
###-end-nr-completion-###
EOF

echo 'Done!'
