alias ls='ls $LS_OPTIONS -hF'
alias ll='ls $LS_OPTIONS -lhF'
alias l='ls $LS_OPTIONS -lAhF'
alias cd..="cd .."
alias dc="cd"
alias ssh="ssh -X"
alias ..="cd .."
alias hl="heroku logs"
alias ggr='git grep -n --color'
alias grdebug='git grep -n --color -l "^ *debugger"| grep -v vendor'
alias be="bundle exec"

if [ -f $HOME/.bash_aliases_local ]; then
  source $HOME/.bash_aliases_local
fi