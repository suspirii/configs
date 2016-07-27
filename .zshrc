HISTFILE=~/.zshhist
HISTSIZE=1000
SAVEHIST=1000
setopt autocd notify
unsetopt beep
bindkey -e

typeset -A key

key[Home]=${terminfo[khome]}

key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

[[ -n "${key[Home]}"     ]]  && bindkey  "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]]  && bindkey  "${key[End]}"      end-of-line
[[ -n "${key[Insert]}"   ]]  && bindkey  "${key[Insert]}"   overwrite-mode
[[ -n "${key[Delete]}"   ]]  && bindkey  "${key[Delete]}"   delete-char
[[ -n "${key[Up]}"       ]]  && bindkey  "${key[Up]}"       up-line-or-history
[[ -n "${key[Down]}"     ]]  && bindkey  "${key[Down]}"     down-line-or-history
[[ -n "${key[Left]}"     ]]  && bindkey  "${key[Left]}"     backward-char
[[ -n "${key[Right]}"    ]]  && bindkey  "${key[Right]}"    forward-char
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"   beginning-of-buffer-or-history
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}" end-of-buffer-or-history

if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        printf '%s' "${terminfo[smkx]}"
    }
    function zle-line-finish () {
        printf '%s' "${terminfo[rmkx]}"
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

setopt HIST_IGNORE_DUPS

autoload -U promptinit
promptinit

autoload -U compinit
compinit

autoload -U colors && colors

#PROMPT="%{$fg_bold[white]%}%m%#%{$reset_color%} "
PROMPT="%{$fg_bold[white]%}>>%{$reset_color%} "
RPROMPT="%{$fg_no_bold[white]%}%~%{$reset_color%}"

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
fi

alias archey='clear && archey'
alias des='shred -uzn 30'
alias hdd='df -h'

alias rb='systemctl reboot'
alias sd='systemctl poweroff'

alias ud='sudo pacman -Syu'
alias yud='yaourt -Syua'

alias ll='ls -lh'
alias l='ls -lha'

alias cl='clear'
alias ht='htop'
alias irc='irssi'
alias mp='mplayer'
alias vi='vim'
alias viwrite='vim -u .vimrc-write'

colortest () {
T='fvkk'
for FGs in '    m' '   1m' '  30m' '1;30m' '  31m' '1;31m' '  32m' '1;32m' '  33m' '1;33m' '  34m' '1;34m' '  35m' '1;35m' '  36m' '1;36m' '  37m' '1;37m';
  do FG=${FGs// /}
  echo -en "\033[$FG  $T  "
  for BG in 40m 41m 42m 43m 44m 45m 46m 47m;
    do echo -en "$EINS \033[$FG\033[$BG  $T  \033[0m";
  done
  echo;
done
echo '\n'
}

case $TERM in *rxvt*)
	precmd(){
		print -Pn "\e]2;zsh %~\a"
	}
	preexec(){
		print -Pn "\e]2;$(echo "$1" | cut -d" " -f1)\a"
	}
	;;
esac

source ~/.scripts/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
