#!/bin/sh

mkdir -p ~/git && \
    cd ~/git && \
    git clone https://github.com/ohmyzsh/ohmyzsh.git && \
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/git/ohmyzsh/custom/themes/powerlevel10k

