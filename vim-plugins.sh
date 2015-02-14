#!/bin/bash
#
# Copyright 2015 Dimitris Zlatanidis <d.zlatanidis@gmail.com>
# All rights reserved.
#
# Redistribution and use of this script, with or without modification, is
# permitted provided that the following conditions are met:
#
# 1. Redistributions of this script must retain the above copyright
# notice, this list of conditions and the following disclaimer.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR "AS IS" AND ANY EXPRESS OR IMPLIED
# WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
# EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
# OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

# This is a simple bash script that installs vim python-mode plugin
# witn indentLine and supertab for Unix-like systems.

# Requirements:
# vim >= 7.3 + Python or Python3

# Installation requirements as usually found 
# in all unix-like systems:
# GNU wget
# Git
# awk

PM_NAME=python-mode
ST_NAME=supertab
IL_NAME=indentLine
ST_VERSION=${ST_VERSION:-2.1}
ST_SOURCE="https://github.com/ervandew/${ST_NAME}/archive/${ST_VERSION}.tar.gz"
PATHOGEN="https://tpo.pe/pathogen.vim"
VIM=".vim"
VIMRC=".vimrc"
PLUGIN=$(echo ${HOME}/${VIM}/plugin)
AUTOLOAD=$(echo ${HOME}/${VIM}/autoload)
BUNDLE=$(echo ${HOME}/${VIM}/bundle)

set -e

# create directories if not exists
echo "Create directories..."
mkdir -p $VIM $AUTOLOAD $BUNDLE $PLUGIN

# install pathogen only if new file exists
echo "Install pathogen.vim..."
wget -N --directory-prefix=$AUTOLOAD $PATHOGEN

# enable pathogen
cat enable_pathogen >> $HOME/$VIMRC

# removes duplicate lines from .vimrc
awk '!x[$0]++' $HOME/$VIMRC > $HOME/$VIMRC.NEW
mv $HOME/$VIMRC.NEW $HOME/$VIMRC

cd $PLUGIN
echo "Install supertab"
rm -rf $ST_NAME
git clone https://github.com/ervandew/supertab.git

cd $BUNDLE
echo "Install vim python-mode..."
rm -rf $PM_NAME
git clone git://github.com/klen/python-mode.git

echo "Install indentLine..."
rm -rf $IL_NAME
git clone https://github.com/Yggdroot/indentLine.git

echo "Done!"
