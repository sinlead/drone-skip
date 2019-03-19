#!/bin/sh

BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)
LOCAL_SHA=$(git rev-parse $BRANCH_NAME)
REMOTE_SHA=$(git ls-remote origin | grep "refs/heads/$BRANCH_NAME" | awk '{print $1}')

if [ "$LOCAL_SHA" = "$REMOTE_SHA" ]; then 
    exit 0
else
    exit -1
fi
