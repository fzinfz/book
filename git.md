<!-- TOC -->

- [Tools](#tools)
- [Download from github](#download-from-github)

<!-- /TOC -->

# Tools
https://rawgit.com/  
http://nbviewer.jupyter.org/

# Download from github
```
$ git clone git@github.com:docker_user/docker_practice.git
$ cd docker_practice
$ git config user.name "yourname"
$ git config user.email "your email"

git commit -am "save arezzo files"

$ git push

git remote add origin https://github.com/XXXX/YYY.git
git config --global push.default simple
git push --set-upstream origin master

# sync with original repo
$ git remote add upstream https://github.com/yeasy/docker_practice
$ git fetch upstream
$ git checkout master
$ git rebase upstream/master
$ git push -f origin master

git pull origin master #fetch + merge
```

git log --since=2.weeks