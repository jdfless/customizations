#!/bin/bash

cp -r .vim ~/
cp .hgrc ~/
cp .vimrc ~/

helping_scripts/copy_to_all.sh /highland/.vim --same --no-prompt
helping_scripts/copy_to_all.sh /highland/.hgrc --same --no-prompt
helping_scripts/copy_to_all.sh /highland/.vim/colors/monokai.vim --same --no-prompt
helping_scripts/copy_to_all.sh /highland/.vim/syntax/puppet.vim --same --no-prompt
