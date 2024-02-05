#!/bin/bash

NEW_REPO_NAME="$(uuidgen)"
NEW_BRANCH="$(uuidgen)"

# Build and minimize
bundle exec jekyll build
html-minifier --collapse-whitespace --remove-comments --remove-optional-tags --remove-redundant-attributes --remove-script-type-attributes --remove-tag-whitespace --use-short-doctype --minify-css true --minify-js true --input-dir=./_site --output-dir=./_site --file-ext html

cd ..
cd blog

# Create new branch
git reset --hard HEAD
git checkout --orphan "$NEW_BRANCH"

# Remove everything and copy
rm -rf *
cp -r ../blog-baseweb/_site/* .

# Save changes
git add .
git commit -m "."
git push

# Rename repository
gh repo rename "$NEW_REPO_NAME" -y

# Info
echo
echo
echo "Change website branch to $NEW_BRANCH at https://github.com/eridem/$NEW_REPO_NAME/settings/pages"
echo "Delete previous branch https://github.com/eridem/$NEW_REPO_NAME/branches"
echo
echo