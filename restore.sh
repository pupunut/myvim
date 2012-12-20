#!/usr/bin/env bash

echo "[myvim] Would you like to restore myvim plugins?"
echo -n "Type Y to restore: "
read line
if [ "$line" = Y ] || [ "$line" = y ]
then
    printf '\033[0;34m%s\033[0m\n' 'Restore myvim plugins...'
    rm -rf $HOME/.vim/bundle/
    git clone git://github.com/gmarik/vundle.git $HOME/.vim/bundle/vundle
    vim +'set nospell' +BundleInstall +qa! $HOME/myvim/tools/info.txt
    printf '\033[0;34m%s\033[0m\n' "myvim plugins were restored. Just enjoy vimming!"
fi
