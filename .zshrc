# Enable colors for commands
export CLICOLOR=1

# Aliases for colored output
alias ls='ls -G'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias ll='ls -Galh'

# Colorful prompt
PS1='%F{green}%n@%m%f %F{blue}%1~%f %# '
