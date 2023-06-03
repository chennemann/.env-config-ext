#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $SCRIPT_DIR

git --git-dir=.envgit clean -df
git --git-dir=.envgit checkout master
git --git-dir=.envgit pull
git pull

cd $HOME
cp -r $SCRIPT_DIR/. $HOME/tmp

rm -rf -- $SCRIPT_DIR