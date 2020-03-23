#!/bin/bash

# get status info from packages to save time in the future
hg --cwd /highland/packages status &>/dev/null &

if ! grep -f pub_key_mac.pub /highland/.ssh/authorized_keys2 &>/dev/null; then
  cat pub_key_mac.pub >> /highland/.ssh/authorized_keys2
fi
if ! grep -f pub_key_lap.pub /highland/.ssh/authorized_keys2 &>/dev/null; then
  cat pub_key_lap.pub >> /highland/.ssh/authorized_keys2
fi
if ! grep -f pub_key_desk.pub /highland/.ssh/authorized_keys2 &>/dev/null; then
  cat pub_key_desk.pub >> /highland/.ssh/authorized_keys2
fi

cp -r vim_dir ~/.vim
cp hgrc ~/.hgrc
cp vimrc ~/.vimrc

helping_scripts/copy_to_all.sh /highland/.vimrc --same --no-prompt
helping_scripts/copy_to_all.sh /highland/.hgrc --same --no-prompt
helping_scripts/copy_to_all.sh /highland/.vim/colors/monokai.vim --same --no-prompt
helping_scripts/copy_to_all.sh /highland/.vim/colors/srcery.vim --same --no-prompt
helping_scripts/copy_to_all.sh /highland/.vim/colors/nachtleben.vim --same --no-prompt
helping_scripts/copy_to_all.sh /highland/.vim/syntax/puppet.vim --same --no-prompt

if [ ! -f ~/.ssh/jdf_skytap_github ]; then
  echo "creating new github ssh key"
  ssh-keygen -f ~/.ssh/jdf_skytap_github -t rsa -b 4096 -C "jflessner@skytap.com" -N ''
  sudo chown 0600 /highland/.ssh/jdf_skytap_github
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
