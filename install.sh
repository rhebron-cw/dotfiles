#!/usr/bin/zsh
#sudo timedatectl set-timezone America/Chicago
echo "$(date) $(git clone git@github.com:rhebron-cw/jira_autobot.git)" >> ~/post_install.log 2>&1
echo "$(date) $(cd jira_autobot && docker-compose up --build -d)" >> ~/post_install.log 2>&1
echo "$(date) Sleeping for 30 seconds $(sleep 30)" >> ~/post_install.log 2>&1
# curl -s --form-string "token=$po_app" --form-string "user=$po_usr" --form-string "message=install.sh completed. \n $(docker ps)" https://api.pushover.net/1/messages.json >> ~/post_install.log 2>&1
echo "$(date) install.sh ran successfully" >> ~/post_install.log 2>&1
