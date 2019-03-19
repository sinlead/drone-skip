#!/bin/sh

echo "machine ${CI_NETRC_MACHINE}" > "${HOME}/.netrc"
echo "login ${CI_NETRC_USERNAME}" >> "${HOME}/.netrc"
echo "password ${CI_NETRC_PASSWORD}" >> "${HOME}/.netrc"

BRANCH_NAME=$DRONE_SOURCE_BRANCH
LOCAL_SHA=$DRONE_COMMIT_SHA
REMOTE_SHA=$(git ls-remote origin | grep "refs/heads/$BRANCH_NAME" | awk '{print $1}')

if [ "$LOCAL_SHA" = "$REMOTE_SHA" ]; then 
  exit 0
else
  echo "Not latest commit. Fail this build by drone-skip."
  exit 1
fi
