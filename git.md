<!-- TOC -->

- [Workflow](#workflow)
- [API](#api)
    - [tag](#tag)
    - [latest release](#latest-release)
- [Tools](#tools)
- [proxy](#proxy)
- [Download from github](#download-from-github)
- [commit & push](#commit--push)
- [branch](#branch)
- [stashing](#stashing)
- [add origin](#add-origin)
- [sync with original repo](#sync-with-original-repo)
- [log](#log)
- [Submodules](#submodules)

<!-- /TOC -->

# Workflow
https://stackoverflow.com/questions/3689838/whats-the-difference-between-head-working-tree-and-index-in-git  
![](https://i.stack.imgur.com/caci5.png)

# API
https://developer.github.com/v3/repos/

## tag
    curl -sSL https://api.github.com/repos/django/django/tags \
        | jq '.[0].zipball_url' | xargs -t wget -O file.zip

## latest release        
    curl -sSL https://api.github.com/repos/ParsePlatform/Parse-SDK-Android/releases/latest \
        | jq '.zipball_url' | xargs -t wget -O file.zip

# Tools
https://rawgit.com/  
http://nbviewer.jupyter.org/

# proxy
    git config --global http.proxy http://proxy_ip:1080

# Download from github

    git clone git@github.com:docker_user/docker_practice.git
    cd docker_practice
    git config user.name "yourname"
    git config user.email "your email"

# commit & push
    git commit -am "save arezzo files"
    git push

# branch
    git branch -a
    git checkout -b dev
    git checkout dev
    git merge master
    git push origin [name_of_your_new_branch]

# stashing
    git stash
    git stash list
    git stash apply/pop
    git stash apply stash@{2}
    git stash drop
    git stash drop stash@{0}

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

# Submodules
https://git-scm.com/book/en/v2/Git-Tools-Submodules    
treat the two projects as separate yet still be able to use one from within the other.