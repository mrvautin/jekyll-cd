#!/bin/bash

echo '🎩 Install Jekyll'
gem install bundler jekyll
bundle install
bundle exec jekyll -v || exit 1

echo '🧹 Clean site'
if [ -d "_site" ]; then
    rm -rf _site/*
fi

echo '🔨 Build site'
bundle exec jekyll build
rm -rf .jekyll-cache

echo '🧪 Deploy build'
git config user.name "${GITHUB_ACTOR}"
git config user.email "${GITHUB_ACTOR}@users.noreply.github.com"
git add .
git commit -am "🧪 Deploy with ${GITHUB_WORKFLOW}"
git push --all -f https://${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git
