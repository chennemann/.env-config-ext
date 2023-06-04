#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $SCRIPT_DIR

TARGET_DIR="$HOME"

git --git-dir=.envgit clean -df
git --git-dir=.envgit checkout master
git --git-dir=.envgit pull
git pull
git --git-dir=.envgit update-index --skip-worktree .gitignore
git ls-files -z .envgit/ | xargs -0 git update-index --skip-worktree
git update-index --skip-worktree initialize.sh
git restore .gitignore
git remote add sync git@github.com:chennemann/.env-config-ext.git
git branch --track github sync/master

cd $TARGET_DIR
yes | cp -r $SCRIPT_DIR/. $TARGET_DIR
rm $TARGET_DIR/initialize.sh

rm -rf -- $SCRIPT_DIR