#!/usr/bin/env bash
# exit on error
set -o errexit

storage_dir=/opt/render/project/src/var
if [ ! -d "$storage_dir" ]; then
  mkdir -p "$storage_dir"
fi

if [ ! -f "$storage_dir/swapfile" ]; then
  fallocate -l 512M "$storage_dir/swapfile"
  chmod 0600 "$storage_dir/swapfile"
  mkswap "$storage_dir/swapfile"
  swapon "$storage_dir/swapfile"
  echo "Swap created and enabled"
else
  swapon "$storage_dir/swapfile"
  echo "Swap enabled"
fi

bundle install
bundle exec rake assets:precompile
bundle exec rake assets:clean
bundle exec rake db:migrate
