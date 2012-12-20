#!/usr/bin/env bash

warn ()
{
    printf '\033[0;31m%s\033[0m\n' "$1" >&2
}

die ()
{
    warn "$1"
    exit 1
}

# check requriements
printf '\033[0;34m%s\033[0m\n' "Checking requriements for myvim..."
printf '\033[0;34m%s\033[0m\n' "Checking vim version..."
vim --version | grep 7.3 || die "Your vim's version is too low!\nPlease download higher version(7.3+) from http://www.vim.org/download.php"
printf '\033[0;34m%s\033[0m\n' "Checking if git exists..."
which git || die "No git installed!\nPlease install git from http://git-scm.com/downloads/"
printf '\033[0;34m%s\033[0m\n' "Check if ctags exists..."
which ctags || warn "No ctags installed!\nPlease install ctags form http://ctags.sourceforge.net/ after myvim intallation!"

# back up existing vim stuff
printf '\033[0;34m%s\033[0m\n' "Backing up current vim config..."
for i in $HOME/.vim $HOME/.vimrc $HOME/.gvimrc; do [ -e $i ] && mv -f $i $i.backup; done

# install myvim
printf '\033[0;34m%s\033[0m\n' "Cloning myvim..."
rm -rf $HOME/myvim
git clone git://github.com/pupunut/myvim.git $HOME/myvim
ln -s $HOME/myvim/vimrc $HOME/.vimrc

printf '\033[0;34m%s\033[0m\n' "Installing Vundle..."
git clone git://github.com/gmarik/vundle.git $HOME/.vim/bundle/vundle

printf '\033[0;34m%s\033[0m\n' "Installing plugins using Vundle..."
vim +'set nospell' +BundleInstall! +BundleClean! +qa! $HOME/myvim/tools/info.txt

printf '\033[0;34m%s\033[0m\n' "myvim has been installed. Just enjoy vimming!"
