#!/bin/bash

git --git-dir=.envgit clean -df
git --git-dir=.envgit checkout master
git --git-dir=.envgit pull
git pull