#!/bin/sh
set -e

echo "machine ${CI_NETRC_MACHINE}" > "${HOME}/.netrc"
echo "login ${CI_NETRC_USERNAME}" >> "${HOME}/.netrc"
echo "password ${CI_NETRC_PASSWORD}" >> "${HOME}/.netrc"

echo "Initialize temporary repository\n"
mkdir -p /tmp/drone-skip/
cd /tmp/drone-skip/
git init
git remote add origin $DRONE_REMOTE_URL

echo "Fetch commit SHA of remote origin\n"
ORIGIN_SHA=$(git ls-remote origin | grep "refs/heads/${DRONE_SOURCE_BRANCH}$" | awk '{print $1}')
echo "Commit SHA of remote origin: ${ORIGIN_SHA}"
echo "Commit SHA of this build: ${DRONE_COMMIT_SHA}\n"

echo "Remote temporary repositiory\n"
rm -rf /tmp/drone-skip/

echo "Check whether commit SHA of this build is latest SHA\n"
if [ "${DRONE_COMMIT_SHA}" = "${ORIGIN_SHA}" ]; then 
  echo "It's latest build. Contiune..."
  exit 0
else
  echo "Not latest commit. Fail this build by drone-skip"
  exit 1
fi
