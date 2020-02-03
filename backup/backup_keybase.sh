#! /usr/bin/env sh

set -e

cd $($HOME/.asdf/shims/node $HOME/.dotfiles/backup/backup_keybase.js)
name=keybase_$(date '+%F')
tar -czf $name.tar ./keybase
rm -rf ./keybase
export LC_ALL=en_US.UTF-8 && cat ./$name.tar | gzip | /usr/local/bin/gpg --encrypt -r alex.popov.tech@gmail.com > /Volumes/BACKUP/$name.gzip.gpg
rm ./$name.tar

# to decrypt
# gpg -o ./archive.tar.gzip -d ./keybase_2020-02-04.gzip.gpg