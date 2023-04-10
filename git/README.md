# git

## .git-setup.sh

### Create a file named `.git-setup.sh`

```shell
install -m 755 /dev/null ~/.git-setup.sh && vim $_ && ~/.git-setup.sh
```

### Paste and run the script

[.git-setup.sh](https://github.com/IanLiuTW/config/blob/main/git/.git-setup.sh)

## 

## Sync folder with existing repo

```shell
git init .
git remote add origin url_of_the_repo
git fetch origin
git branch -f master origin/main
git reset .
```
