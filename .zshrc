eval "$(direnv hook zsh)"
# Enable colors for commands
export CLICOLOR=1

# Aliases for colored output
alias ls='ls -G'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias ll='ls -Galh'
alias dlog='sudo cat /var/lib/docker/volumes/jira-walkthrough-cron_wt-jira/_data/cron.log'

# Colorful prompt
PS1='%F{green}%n@%m%f %F{blue}%1~%f %# '

# Pull in other aliases and secrets
if [ -f ~/.alias ]; then
	source ~/.alias
else
	print ".alias file not found"
fi
if [ -f ~/.secretenv ]; then
	source ~/.secretenv
else
	print ".secretenv not found"
fi
