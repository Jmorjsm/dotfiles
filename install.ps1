# Setup the global gitignore
git config --global core.excludesFile "$Env:USERPROFILE\.gitignore"
# TODO: ask for these
# git config --global user.name=Jon Morgan
# git config --global user.email=jmorjsm@gmail.com
# TODO: These won't work
# Setup Aliases
git config --global alias.lg=log --graph --decorate --oneline
git config --global alias.push-fwl=push --force-with-lease
git config --global alias.commit-a=commit --amend
git config --global alias.commit-an=commit --amend --no-edit
# Stop having to push --set-upstream origin [branchName]
git config --global push.default=current
