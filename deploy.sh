#!/bin/bash

echo ------------------------------------------------------------------------------------------
set | sed -e "s/^\(.*TOKEN=\).*/\1[secure]/g"
echo ------------------------------------------------------------------------------------------

php sculpin.phar install

php sculpin.phar generate --env=prod

cd output_prod

git config --global user.email "touroku@sharkpp.net"
git config --global user.name  "sharkpp"

git init
git add .
git commit -m "Deploy to GitHub Pages"
git push --force --quiet "https://${GH_TOKEN}@github.com/${TRAVIS_REPO_SLUG}.git" master:gh-pages > /dev/null 2>&1

