#!/bin/sh
set -e

echo "#### Running Deploy Script ####"

# setup ssh-agent and provide the GitHub deploy key
eval "$(ssh-agent -s)"
chmod 600 deploy_rsa
ssh-add deploy_rsa

ssh -oStrictHostKeyChecking=no -p$PORT $SERVER "cd fablabs.io; ./scripts/deploy.sh"
