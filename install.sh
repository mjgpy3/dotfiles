#!/bin/bash

dotfile=$1

if [ "$dotfile" == "bashrc" ]; then
	echo "Appending bashrc to ~/.bashrc"
	cat bashrc >> ~/.bashrc
fi

if [ "$dotfile" == "vimrc" ]; then
	echo "Installing vimrc as ~/.vimrc"
	cp vimrc ~/.vimrc
	echo "Making ~/.vim/backup and ~/.vim/tmp directories"
	mkdir -p ~/.vim/backup
	mkdir -p ~/.vim/tmp
fi
