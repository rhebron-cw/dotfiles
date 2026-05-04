#!/usr/bin/zsh
git clone git@github.com:rhebron-cw/jira_autobot.git
cd jira_autobot
docker compose up --build -d
echo "$(date) install.sh ran successfully" >> ~/post_install.log
