#!/bin/bash
set -e

# Executes pullrequest_$action.sh script based on Github API PullRequestEvent
# see; https://developer.github.com/v3/activity/events/types/#pullrequestevent

# Init Variables
logfile=${logfile:-/var/log/webhook.log}

exec &> >(tee -a "$logfile")
echo `date` - Executing $0 
echo `date` - with HOOK_PAYLOAD : >> $logfile
echo ------------------ >> $logfile
echo $HOOK_PAYLOAD >> $logfile
echo ------------------ >> $logfile

PRaction=$(echo $HOOK_PAYLOAD | jq '.action')

case $PRaction in
	"\"opened\"")
		echo `date` - Executing pullrequest_opened.sh 
		./pullrequest_opened.sh ;;
	"\"edited\"")
		echo `date` - Executing pullrequest_edited.sh  
		./pullrequest_edited.sh ;;
	"\"closed\"")
		echo `date` - Executing pullrequest_closed.sh 
		./pullrequest_closed.sh ;;
	"\"reopened\"")
		echo `date` - PR Reopened not implemented yet ;;
	"\"synchronize\"")
		echo `date` - PR sync not implemented yet ;;
	*) echo Not yet supported ;;
esac

echo `date` - Done executing $0
