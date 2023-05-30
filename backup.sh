#!/bin/bash

# Compress the folder with foldername +date and take backup
filename="backup_`date +%Y`_`date +%m`_`date +%d`.tgz";

# create backup folder
mkdir -p /opt/backup

# send notification to slack using webhook

# Set the web-hook URL

WEBHOOK_URL="https://hooks.slack.com/services/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"

# Create compressed file using tar and move to backup folder
 
tar cvzf /opt/backup/$filename /home/ubuntu

# Check the return value of above command and store it in variable 'retVal'

retVal=$?

# If the value is equal to zero then files transfered successfully otherwise it got failed transfer.
if [ $retVal -eq 0 ]
    then
    	curl -X POST -H 'Content-type: application/json' --data '{"text":"files transfered successfully"}' $WEBHOOK_URL
    else
        curl -X POST -H 'Content-type: application/json' --data '{"text":"files are not transfrred successfully"}' $WEBHOOK_URL
fi


# Change directory to Backup folder
cd /opt/backup

# List the content
ls

# Remove backup files that are older than 7 days.
find "/opt/backup" -type f -mtime +7 -exec rm {} \;

