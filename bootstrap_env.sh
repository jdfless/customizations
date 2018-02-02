#!/bin/bash

if ! grep -f pub_key.pub /highland/.ssh/authorized_keys2 &>/dev/null; then
  cat pub_key.pub >> /highland/.ssh/authorized_keys2
fi

cp -r vim_dir ~/.vim
cp hgrc ~/.hgrc
cp vimrc ~/.vimrc

helping_scripts/copy_to_all.sh /highland/.vimrc --same --no-prompt
helping_scripts/copy_to_all.sh /highland/.hgrc --same --no-prompt
helping_scripts/copy_to_all.sh /highland/.vim/colors/monokai.vim --same --no-prompt
helping_scripts/copy_to_all.sh /highland/.vim/syntax/puppet.vim --same --no-prompt
