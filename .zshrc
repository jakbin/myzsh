# ~/.zshrc file for zsh non-login shells.
# see /usr/share/doc/zsh/examples/zshrc for examples
source /etc/zsh_command_not_found     # command-not-found suggestions for zsh

setopt autocd              # change directory just by typing its name
setopt correct             # auto correct mistakes
setopt interactivecomments # allow comments in interactive mode
# setopt ksharrays           # arrays start at 0
setopt magicequalsubst     # enable filename expansion for arguments of the form ‘anything=expression’
setopt nonomatch           # hide error message if there is no match for the pattern
setopt notify              # report the status of background jobs immediately
setopt numericglobsort     # sort filenames numerically when it makes sense
setopt promptsubst         # enable command substitution in prompt

WORDCHARS=${WORDCHARS//\/} # Don't consider certain characters part of the word

# hide EOL sign ('%')
export PROMPT_EOL_MARK=""

# configure key keybindings
bindkey -e                                        # emacs key bindings
bindkey ' ' magic-space                           # do history expansion on space
bindkey '^[[3;5~' kill-word                       # ctrl + Supr
bindkey '^[[1;5C' forward-word                    # ctrl + ->
bindkey '^[[C' forward-word                       # ctrl + ->
bindkey '^[[1;5D' backward-word                   # ctrl + <-
bindkey '^[[D' backward-word                      # ctrl + <-
bindkey '^[[5~' beginning-of-buffer-or-history    # page up
bindkey '^[[6~' end-of-buffer-or-history          # page down
bindkey '^[[Z' undo                               # shift + tab undo last action

# enable completion features
# autoload -Uz compinit
# compinit -d ~/.cache/zcompdump
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # case insensitive tab completion

# History configurations
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=10000
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
#setopt share_history         # share command history data

# force zsh to show the complete history
alias history="history 0"
# setopt prompt_subst

# Enabling and setting git info var to be used in prompt config.
    autoload -Uz vcs_info
    zstyle ':vcs_info:*' enable git svn
    # This line obtains information from the vcs.
    zstyle ':vcs_info:git*' formats "(%b) "
    precmd() {
        vcs_info
    }

# Prompt
prompt="%B%F{red}┌%f"'${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV))}'"%F{red}[%f%F{green}%n%f%F{yellow}㉿%f%F{cyan}%m%f%F{red}]─[%F{magenta}%(6~.%-1~/…/%4~.%5~)%f%F{red}]%f%F{201}"'${vcs_info_msg_0_}'"%f"$'\n'"%F{red}└╼%f%F{yellow}$%f%b"

# Export PATH$
export PATH=~/.local/bin:/snap/bin:/usr/sandbox/:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/usr/share/games:/usr/local/sbin:/usr/sbin:/sbin:$PATH

case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi


if [ "$color_prompt" = yes ]; then
    # override default virtualenv indicator in prompt
    VIRTUAL_ENV_DISABLE_PROMPT=1

	# enable syntax-highlighting
	if [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && [ "$color_prompt" = yes ]; then
		# ksharrays breaks the plugin. This is fixed now but let's disable it in the
		# meantime.
		# https://github.com/zsh-users/zsh-syntax-highlighting/pull/689
		# unsetopt ksharrays

		. /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
		ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
		ZSH_HIGHLIGHT_STYLES[default]=none
		ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=red,bold
		ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=cyan,bold
		ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=green,underline
		ZSH_HIGHLIGHT_STYLES[global-alias]=fg=magenta
		ZSH_HIGHLIGHT_STYLES[precommand]=fg=green,underline
		ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=blue,bold
		ZSH_HIGHLIGHT_STYLES[autodirectory]=fg=green,underline
		ZSH_HIGHLIGHT_STYLES[path]=underline
		ZSH_HIGHLIGHT_STYLES[path_pathseparator]=
		ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]=
		ZSH_HIGHLIGHT_STYLES[globbing]=fg=blue,bold
		ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=blue,bold
		ZSH_HIGHLIGHT_STYLES[command-substitution]=none
		ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]=fg=magenta
		ZSH_HIGHLIGHT_STYLES[process-substitution]=none
		ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]=fg=magenta
		ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=magenta
		ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=magenta
		ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
		ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]=fg=blue,bold
		ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=yellow
		ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=yellow
		ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]=fg=yellow
		ZSH_HIGHLIGHT_STYLES[rc-quote]=fg=magenta
		ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=magenta
		ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=magenta
		ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]=fg=magenta
		ZSH_HIGHLIGHT_STYLES[assign]=none
		ZSH_HIGHLIGHT_STYLES[redirection]=fg=blue,bold
		ZSH_HIGHLIGHT_STYLES[comment]=fg=black,bold
		ZSH_HIGHLIGHT_STYLES[named-fd]=none
		ZSH_HIGHLIGHT_STYLES[numeric-fd]=none
		ZSH_HIGHLIGHT_STYLES[arg0]=fg=green
		ZSH_HIGHLIGHT_STYLES[bracket-error]=fg=red,bold
		ZSH_HIGHLIGHT_STYLES[bracket-level-1]=fg=blue,bold
		ZSH_HIGHLIGHT_STYLES[bracket-level-2]=fg=green,bold
		ZSH_HIGHLIGHT_STYLES[bracket-level-3]=fg=magenta,bold
		ZSH_HIGHLIGHT_STYLES[bracket-level-4]=fg=yellow,bold
		ZSH_HIGHLIGHT_STYLES[bracket-level-5]=fg=cyan,bold
		ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]=standout
	fi
else
    PROMPT='${debian_chroot:+($debian_chroot)}%n@%m:%~%# '
fi
unset color_prompt force_color_prompt

# enable color support of ls, less and man, and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias diff='diff --color=auto'
    alias ip='ip --color=auto'

    export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
    export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
    export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
    export LESS_TERMCAP_so=$'\E[01;33m'    # begin reverse video
    export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
    export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
    export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

    # Take advantage of $LS_COLORS for completion as well
    zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
fi

# alias
# alias ls='ls -lh --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
# alias fgrep='fgrep --color=auto'
# alias egrep='egrep --color=auto'
alias bat='batcat'

# some more ls aliases
# alias l='ls -CF'
alias em='emacs -nw'
alias dd='dd status=progress'
alias _='sudo'
alias _i='sudo -i'
alias please='sudo'
alias fucking='sudo'

### LS & TREE
alias ls='ls --color=auto'
alias ll='ls -l'
alias lla='ls -la'
alias la='ls -A'
# alias l='ls -F'
command -v lsd > /dev/null && alias ls='lsd --group-dirs first' && \
	alias tree='lsd --tree'
command -v colorls > /dev/null && alias ls='colorls --sd --gs' && \
	alias tree='colorls --tree'

source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# source /usr/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# Select all suggestion instead of top on result only
zstyle ':autocomplete:tab:*' insert-unambiguous yes
zstyle ':autocomplete:tab:*' widget-style menu-select
zstyle ':autocomplete:*' min-input 2
bindkey $key[Up] up-line-or-history
bindkey $key[Down] down-line-or-history


##################################################
# Fish like syntax highlighting
# Requires "zsh-syntax-highlighting" from apt
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Useful alias for benchmarking programs
# require install package "time" sudo apt install time
# alias time="/usr/bin/time -f '\t%E real,\t%U user,\t%S sys,\t%K amem,\t%M mmem'"

# Display last command in terminal
echo -en "\e]2;Kali  Terminal\a"
preexec () { print -Pn "\e]0;$1 - Kali Terminal\a" }

