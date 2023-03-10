# ~/.zshrc

# Enable colors and change prompt:
autoload -U colors && colors
setopt autocd              # change directory just by typing its name
setopt correct             # auto correct mistakes
setopt interactivecomments # allow comments in interactive mode
setopt magicequalsubst     # enable filename expansion for arguments of the form ‘anything=expression’
setopt nonomatch           # hide error message if there is no match for the pattern
setopt notify              # report the status of background jobs immediately
setopt numericglobsort     # sort filenames numerically when it makes sense
setopt promptsubst         # enable command substitution in prompt

# enable completion features
autoload -Uz compinit
compinit -d ~/.cache/zcompdump
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' rehash true
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# configure key keybindings
bindkey -e                                        # emacs key bindings
bindkey '^[[3;5~' kill-word                       # ctrl + Supr
bindkey '^[[3~' delete-char                       # delete
bindkey '^[[1;5C' forward-word                    # ctrl + ->
bindkey '^[[1;5D' backward-word                   # ctrl + <-
bindkey '^[[5~' beginning-of-buffer-or-history    # page up
bindkey '^[[6~' end-of-buffer-or-history          # page down
bindkey '^[[H' beginning-of-line                  # home
bindkey '^[[F' end-of-line                        # end
bindkey '^[[Z' undo                               # shift + tab undo last action
bindkey '	' autosuggest-accept              # tab



# Default Programs
export EDITOR="nano"
export PAGER="less"
export BROWSER="firefox"
export MOVPLAY="mpv"
export PICVIEW="eog"
export SNDPLAY="mpv"
export CM_LAUNCHER=rofi
export TERMINAL="st"
export PULSE_LATENCY_MSEC=60
export TERM="xterm-256color"


# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*|Eterm|aterm|kterm|gnome*|alacritty)
    TERM_TITLE=$'\e]0;%n@%m: %1~\a'
    ;;
*)
    ;;
esac
precmd() {
    # Print the previously configured title
    print -Pnr -- "$TERM_TITLE"

    # Print a new line before the prompt, but only if it is not the first line
    if [ "$NEWLINE_BEFORE_PROMPT" = yes ]; then
        if [ -z "$_NEW_LINE_BEFORE_PROMPT" ]; then
            _NEW_LINE_BEFORE_PROMPT=1
        fi
    fi
}

############# Prompts #############
# Git branch in prompt :
autoload -Uz vcs_info # enable vcs_info
autoload -U colors && colors
precmd () { vcs_info } # always load before displaying the prompt
#zstyle ':vcs_info:*' formats ' %s(%b)' # git(main)
zstyle ':vcs_info:*' formats '%F{red}(%F{green} %b%F{red})%F{rest}' # ( main)

# Minimal Prompt no Color :
#PS1="%B[%n@%M %1~]%{$reset_color%}$%b "
# Minimal Prompt no Color with git :
#PS1='%B[%n@%M %1~]$vcs_info_msg_0_$%b '

# Main Prompt : 
#PS1='%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%1~%{$fg[red]%}]$vcs_info_msg_0_%{$fg[magenta]%}→%{$reset_color%}%b '
# Mini Main Prompt :
#PS1='%B%{$fg[red]%}[%{$fg[yellow]%}  %{$fg[blue]%}  %{$fg[magenta]%} %1~%{$fg[red]%} ]$vcs_info_msg_0_%{$fg[magenta]%}→%{$reset_color%}%b ' 
PS1='%B%{$fg[cyan]%} %{$fg[blue]%} %1~ $vcs_info_msg_0_%{$fg_bold[magenta]%}%{$reset_color%}%b ' 

############# Configurations #############
# History configurations
HISTFILE=~/.cache/.zsh_history
HISTSIZE=1000
SAVEHIST=2000
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
#setopt share_history         # share command history data

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
#_comp_options+=(globdots)		# Include hidden files.


# enable auto-suggestions based on the history
if [ -f ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    . ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
    # change suggestion color
    #ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999'
fi

# Load zsh-syntax-highlighting; should be last.
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

### RANDOM COLOR SCRIPT ###
# Get this script from my GitLab: gitlab.com/dwt1/shell-color-scripts
# Or install it from the Arch User Repository: shell-color-scripts
#colorscript random
