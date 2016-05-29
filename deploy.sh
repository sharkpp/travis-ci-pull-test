#!/bin/bash

echo ------------------------------------------------------------------------------------------
set
echo ------------------------------------------------------------------------------------------

php sculpin.phar install

php sculpin.phar generate --env=prod

cd output_prod

git config user.email "touroku@sharkpp.net"
git config user.name  "sharkpp"

git init
git add .
git commit -m "Deploy to GitHub Pages"
git push --force --quiet "https://${GH_TOKEN}@github.com/sharkpp/travis-ci-pull-test.git" master:gh-pages > /dev/null 2>&1

