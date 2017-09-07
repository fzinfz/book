<!-- TOC -->

- [API](#api)
    - [tag & latest release](#tag--latest-release)
- [Tools](#tools)
- [Download from github](#download-from-github)
- [commit & push](#commit--push)
- [add origin](#add-origin)
- [sync with original repo](#sync-with-original-repo)
- [log](#log)

<!-- /TOC -->

# API
https://developer.github.com/v3/repos/

## tag & latest release
https://api.github.com/repos/django/django/tags
https://api.github.com/repos/ParsePlatform/Parse-SDK-Android/releases/latest

# Tools
https://rawgit.com/  
http://nbviewer.jupyter.org/

# Download from github

    git clone git@github.com:docker_user/docker_practice.git
    cd docker_practice
    git config user.name "yourname"
    git config user.email "your email"

# commit & push
    git commit -am "save arezzo files"
    git push

# add origin
    git remote add origin https://github.com/XXXX/YYY.git
    git config --global push.default simple
    git push --set-upstream origin master

# sync with original repo
    git remote add upstream https://github.com/yeasy/docker_practice
    git fetch upstream
    git checkout master
    git rebase upstream/master
    git push -f origin master

    git pull origin master # fetch + merge

# log
    git log --since=2.weeks