<!-- TOC -->

- [Learn](#learn)
- [Workflow](#workflow)
    - [commit](#commit)
    - [log](#log)
    - [branch and merge](#branch-and-merge)
    - [Undo](#undo)
    - [stashing](#stashing)
    - [remote and push](#remote-and-push)
        - [delete remote branch](#delete-remote-branch)
- [config](#config)
    - [Proxy](#proxy)
- [filter-branch](#filter-branch)
- [Remove File](#remove-file)
    - [Unpushed commit](#unpushed-commit)
    - [Every commit](#every-commit)
    - [from Github](#from-github)
- [rebase](#rebase)
- [fork](#fork)
- [Submodules](#submodules)
- [Github API](#github-api)
    - [Download by tag](#download-by-tag)
    - [curl Github](#curl-github)
    - [Query latest release](#query-latest-release)
- [Github](#github)
- [Self-host git servers](#self-host-git-servers)
- [Tools](#tools)

<!-- /TOC -->

# Learn
- Practise: https://learngitbranching.js.org/?locale=en_US  

- Cheatsheet
    - 4 Pages: https://about.gitlab.com/images/press/git-cheat-sheet.pdf
    - 2 Pages: https://education.github.com/git-cheat-sheet-education.pdf
    - 2 Pages: https://www.atlassian.com/dam/jcr:8132028b-024f-4b6b-953e-e68fcce0c5fa/atlassian-git-cheatsheet.pdf

- Books
    - https://git-scm.com/book/en/v2
    
[my functions](https://github.com/fzinfz/scripts/blob/master/lib/git.sh#L1):
```bash
source /dev/stdin <<< "$(curl -sSL https://raw.githubusercontent.com/fzinfz/scripts/master/lib/git.sh)"
```

# Workflow
https://stackoverflow.com/questions/3689838/whats-the-difference-between-head-working-tree-and-index-in-git  
![](https://i.stack.imgur.com/caci5.png)

    cat .git/HEAD       # current branch head
        ref: refs/heads/master
    cat .git/ORIG_HEAD ; git show | head -1

`working tree` don't include `untracked files`

## commit
    git commit -am "save arezzo files"
    git commit --amend
        -c, --reedit-message <commit>   # reuse and edit message from specified commit
        -C, --reuse-message <commit>    # reuse message from specified commit

## log
    git log [<options>] [<revision-range>] [[--] <path>...]
    git show [<options>] <object>...
    git show [path] # details of last commit log
    git log --since=2.weeks

## branch and merge
    git branch -a       # list all

    git checkout -b dev # create and checkout a new branch

    git checkout master
    git merge dev       # merge dev into master
        --squash              create a single commit instead of doing a merge
        --abort               abort the current in-progress merge

## Undo
https://www.atlassian.com/git/tutorials/resetting-checking-out-and-reverting

    git checkout -- <file>    # discard changes in working directory

    git reset HEAD~2    # undo 2 changes that haven’t been shared
    git reset <paths>   # opposite of `git add <paths>`
        --soft                reset HEAD only
        --mixed               reset HEAD and index (default)
        --hard                reset HEAD, index and working tree
        --merge               reset HEAD, index and working tree
        --keep                reset HEAD but keep local changes

    git revert HEAD~2   # undo 2 changes on a public branch

https://stackoverflow.com/questions/3639342

    git reset master
    git checkout master

![](https://i.stack.imgur.com/UWGiw.png)

## stashing
    git stash
    git stash list
    git stash apply/pop
    git stash apply stash@{2}
    git stash drop
    git stash drop stash@{0}

## remote and push
https://git-scm.com/book/en/v2/Git-Internals-The-Refspec

    git remote -v
    git remote add [<options>] <name> <url>
        -f, --fetch           fetch the remote branches
        --tags
        --no-tags
        -t, --track <branch>        # branch(es) to track
        -m, --master <branch>
        --mirror[=<push|fetch>]     # set up remote as a mirro

    cat .git/config
        `refspec`:     +<src>:<dst>
        <src> is the pattern for references on the remote side
        <dst> is where those references will be tracked locally

        [remote "origin"]
            fetch = +refs/heads/*:refs/remotes/origin/*
            fetch = +refs/heads/master:refs/remotes/origin/master
            fetch = +refs/heads/foo/*:refs/remotes/origin/foo/*

    git push -u origin master:refs/heads/foo/master

            push = refs/heads/master:refs/heads/qa/master

    tree .git/refs/
        .git/refs/
        ├── heads
        │   ├── dev
        │   └── master
        ├── remotes
        │   └── origin
        │       └── HEAD
        └── tags

    git push [<options>] [<repository> [<refspec>...]]
        -u, --set-upstream    set upstream for git pull/status
    git pull origin master # fetch + merge

### delete remote branch
    git push origin :topic
    git push origin --delete topic

# config
    git config -l
        --global              ~/.gitconfig
        --local               .git/config
            core.repositoryformatversion=0
            core.filemode=true
            core.bare=false
            core.logallrefupdates=true
        --system              /etc/gitconfig

        --get                 get value: name [value-regex]
        --get-all             get all values: key [value-regex]
        --get-regexp          get values for regexp: name-regex [value-regex]
        --get-urlmatch        get value specific for the URL: section[.var] URL
        --replace-all         replace all matching variables: name value [value_regex]
        --add                 add a new variable: name value
        --unset               remove a variable: name [value-regex]
        --unset-all           remove all matches: name [value-regex]

    git config --global push.default simple
    git config --list --show-origin
    
## Proxy
    git config --global http.proxy http://$IP:$Port

# filter-branch
https://manishearth.github.io/blog/2017/03/05/understanding-git-filter-branch/

    [--setup <command>] 
    [--env-filter <command>]
	[--tree-filter <command>] 
    [--index-filter <command>]
	[--parent-filter <command>] 
    [--msg-filter <command>]
	[--commit-filter <command>] 
    [--tag-name-filter <command>]
	[--subdirectory-filter <directory>] 
    [--original <namespace>]
	[-d <directory>] [-f | --force] [--] [<rev-list options>...]

# Remove File
## Unpushed commit
    git rm --cached giant_file # leave it on disk
    git commit --amend -CHEAD

## Every commit
    git filter-branch --tree-filter 'rm -f filename' HEAD
        --all       # all branches

    git filter-branch --index-filter \
        'git rm --cached --ignore-unmatch filename' HEAD

## from Github
https://help.github.com/articles/removing-sensitive-data-from-a-repository/

# rebase
https://git-scm.com/book/en/v2/Git-Branching-Rebasing

    git remote add upstream https://github.com/yeasy/docker_practice
    git fetch upstream
    git checkout master
    git rebase upstream/master
    git push -f origin master

# fork
https://stackoverflow.com/questions/14587045/how-to-merge-branch-of-forked-repo-into-master-branch-of-original-repo

# Submodules
https://git-scm.com/book/en/v2/Git-Tools-Submodules    
treat the two projects as separate yet still be able to use one from within the other.

# Github API
https://developer.github.com/v3/repos/

## Download by tag
    curl -sSL https://api.github.com/repos/django/django/tags \
        | jq '.[0].zipball_url' | xargs -t wget -O file.zip

## curl Github
https://github.com/settings/tokens

    curl -H 'Authorization: token INSERT_ACCESS_TOKEN_HERE' \
        -H 'Accept: application/vnd.github.v3.raw' -O -L \
        https://api.github.com/repos/owner/repo/contents/path

## Query latest release
    curl -sSL https://api.github.com/repos/ParsePlatform/Parse-SDK-Android/releases/latest \
        | jq '.zipball_url' | xargs -t wget -O file.zip

# Github
check watchers: https://github.com/{user}/{project}/watchers

# Self-host git servers
Go: https://github.com/go-gitea/gitea  
Go: https://github.com/gogs/gogs  
Ruby: https://gitlab.com/gitlab-org/gitlab

# Tools
curl -L https://github.com...?raw=true  
.html to page, etc: https://rawgit.com/  
.js CDN: https://cdnjs.com/  https://cdn.jsdelivr.net/gh/user/repo@version/file  
.ipynb fast open: http://nbviewer.jupyter.org/  
Code search: https://about.sourcegraph.com/  
download: https://minhaskamal.github.io/DownGit/#/home  


