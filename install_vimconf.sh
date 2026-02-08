#!/bin/sh

mkdir -p ~/git && \
    cd ~/git && \
    git clone https://github.com/timss/vimconf.git && \
    ln -s ~/git/vimconf/.vimrc ~

