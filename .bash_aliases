# alias ls='ls $LS_OPTIONS -hF'
# alias ll='ls $LS_OPTIONS -lhF'
# alias l='ls $LS_OPTIONS -lAhF'
alias cd..="cd .."
alias sshx="ssh -X"
alias ssh="TERM=xterm-256color ssh"
alias ggr='git grep -n --color'
alias grdebug='git grep -n --color -l "^ *debugger"| grep -v vendor'
alias be="bundle exec"
alias clipin="xsel --clipboard <"
alias clipout="xsel --clipboard >"
alias xsel="xsel --clipboard"
alias open="gio open"
alias reboot="sudo reboot"
alias dc="docker-compose"
alias dr="docker-compose run app"
alias drr="docker-compose run app rspec -r factories"
alias dcn="docker-compose run app nosetests -s"
alias tags="tags -R extra=+f"
alias notes="cd ~/notes && vi -c NotesLayout"
alias ksf="kubectl --kubeconfig /home/dimus/.kube/sf.config"
alias hsf="KUBECONFIG=/home/dimus/.kubernetes/admin.conf helm"
alias kd="kubectl delete -f "
alias ka="kubectl apply -f "
alias ke="kubectl exec -it "
alias kec="kubectl exec -itc "
alias gitdel="git remote prune origin && git br |grep -v master |xargs -I {} git branch -D `$HOME/bin/trim {}`"
alias dimus="gpg -d ~/notes/important/dimus.asc"
alias down="sudo shutdown -h now"
alias v=vicd
alias vv=vifm
alias vi="nvim"
alias xx="startx"
alias xclip="xclip -selection c"
alias eq="qpaeq"
alias mic="arecord -vv -f  dat /dev/null"
alias sys="sudo systemctl"
alias pg="sudo systemctl start postgresql"
alias sysu="systemctl --user"
alias btrfs="sudo btrfs"
alias sn="sudo snapper"
alias cb="cargo build"
alias cc="cargo check"
alias ct="cargo test --"
alias cr="cargo run --"
alias cw="cargo watch -x"
alias scr="sudo btrfs scrub status /"
alias re="rustc --explain"

if [ -f $HOME/.bash_aliases_local ]; then
  source $HOME/.bash_aliases_local
fi
