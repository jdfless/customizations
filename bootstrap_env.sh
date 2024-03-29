#!/bin/bash

if ! grep -f pub_key_mac.pub ~/.ssh/authorized_keys2 &>/dev/null; then
  cat pub_key_mac.pub >> ~/.ssh/authorized_keys2
fi
if ! grep -f pub_key_lap.pub ~/.ssh/authorized_keys2 &>/dev/null; then
  cat pub_key_lap.pub >> ~/.ssh/authorized_keys2
fi
if ! grep -f pub_key_desk.pub ~/.ssh/authorized_keys2 &>/dev/null; then
  cat pub_key_desk.pub >> ~/.ssh/authorized_keys2
fi

cp -r vim_dir ~/.vim
cp hgrc ~/.hgrc
cp gitconfig ~/.gitconfig
cp vimrc ~/.vimrc

helping_scripts/copy_to_all.sh ~/.vimrc --same --no-prompt
helping_scripts/copy_to_all.sh ~/.hgrc --same --no-prompt
helping_scripts/copy_to_all.sh ~/.gitconfig --same --no-prompt
helping_scripts/copy_to_all.sh ~/.vim/colors/monokai.vim --same --no-prompt
helping_scripts/copy_to_all.sh ~/.vim/colors/srcery.vim --same --no-prompt
helping_scripts/copy_to_all.sh ~/.vim/colors/nachtleben.vim --same --no-prompt
helping_scripts/copy_to_all.sh ~/.vim/syntax/puppet.vim --same --no-prompt

if [ ! -f ~/.ssh/jdf_skytap_github ]; then
  echo "creating new github ssh key"
  ssh-keygen -f ~/.ssh/jdf_skytap_github -t rsa -b 4096 -C "jflessner@skytap.com" -N ''
  sudo chmod 0600 ~/.ssh/jdf_skytap_github
  git remote set-url origin git@github.com:jdfless/customizations.git
fi

git config --global user.email "jflessner@skytap.com"
git config --global user.name "Jonathan Flessner"

cat <<END > ~/.ssh/config
Host github.com
  User highland
  IdentityFile ~/.ssh/jdf_skytap_github
END

helping_scripts/copy_to_all.sh ~/.ssh/jdf_skytap_github --same --no-prompt
helping_scripts/copy_to_all.sh ~/.ssh/config --same --no-prompt

echo "don't forget to add pubkey to github acct"
echo "  - https://github.com/settings/keys"
cat ~/.ssh/jdf_skytap_github.pub
