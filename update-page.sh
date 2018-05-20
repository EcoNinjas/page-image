#!/usr/bin/env sh

PAGE_ROOT=/econinja

if [ -d "$PAGE_ROOT" ]
then
  echo "base dir exists"
else
  mkdir -p "$PAGE_ROOT"
fi

echo "Fetching latest content"
if [ -d "$PAGE_ROOT"/content ]
then
  cd "$PAGE_ROOT"/content
  git pull || git reset --hard origin/master
else
  git clone https://github.com/EcoNinjas/page-content.git "$PAGE_ROOT"/content
fi

echo "Fetching latest design & layout"
if [ -d "$PAGE_ROOT"/design ]
then
  cd "$PAGE_ROOT"/design
  git pull || git reset --hard origin/master
else
  git clone https://github.com/EcoNinjas/page-design.git "$PAGE_ROOT"/design
fi

echo "Applying webpage updates"
rsync -r "$PAGE_ROOT"/content/ "$PAGE_ROOT"/page
rsync -r "$PAGE_ROOT"/design/ "$PAGE_ROOT"/page

if [ "$1" == "--firstrun" ]
then
   cd "$PAGE_ROOT"/page; bundle install --production --clean --no-cache; bundle exec jekyll build
else
    cd "$PAGE_ROOT"/page; bundle exec jekyll build
fi
