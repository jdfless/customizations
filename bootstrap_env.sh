#!/bin/bash

repo="$1"

if [ -z "$repo" ]; then
  echo "pass the current repo the stack is on, i.e. 'r1644'"
  exit 1
fi

cp -r .vim ~/
cp .hgrc ~/
cp .vimrc ~/

# allow pushes with jdf
helping_scripts/add_jdf_to_repo.sh r1644

helping_scripts/copy_to_all.sh /highland/.vim --same --no-prompt
helping_scripts/copy_to_all.sh /highland/.hgrc --same --no-prompt
helping_scripts/copy_to_all.sh /highland/.vim/colors/monokai.vim --same --no-prompt
helping_scripts/copy_to_all.sh /highland/.vim/syntax/puppet.vim --same --no-prompt
