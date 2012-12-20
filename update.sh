#!/usr/bin/env bash

echo "[myvim] Would you like to update myvim?"
echo -n "Type Y to update: "
read line
if [ "$line" = Y ] || [ "$line" = y ]
then
    # update myvim
    printf '\033[0;34m%s\033[0m\n' 'Upgrading myvim...'
    cd $HOME/myvim/
    if git pull origin master
    then
        vim +'set nospell' +BundleInstall! +BundleClean! +mapclear +qa! $HOME/myvim/tools/info.txt
        printf '\033[0;34m%s\033[0m\n' 'myvim has been updated and is at the current version.'
    else
        printf '\033[0;31m%s\033[0m\n' 'There was an error updating. Try again later?'
    fi
fi
