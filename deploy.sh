#!/bin/bash

#echo ------------------------------------------------------------------------------------------
#set | sed -e "s/^\(.*TOKEN=\).*/\1[secure]/g"
#echo ------------------------------------------------------------------------------------------

php sculpin.phar install

php sculpin.phar generate --env=prod

pushd output_prod

git config --global user.email "touroku@sharkpp.net"
git config --global user.name  "sharkpp"

git init
git add .
git commit -m "Deploy to GitHub Pages"
git push --force --quiet "https://${GH_TOKEN}@github.com/${TRAVIS_REPO_SLUG}.git" master:gh-pages > /dev/null 2>&1

popd

cat .tw.yml | sed \
    -e "s/TW_CONSUMER_KEY/${TW_CONSUMER_KEY}/g" \
    -e "s/TW_CONSUMER_SECRET/${TW_CONSUMER_SECRET}/g" \
    -e "s/TW_USER_ACCESS_TOKEN/${TW_USER_ACCESS_TOKEN}/g" \
    -e "s/TW_USER_ACCESS_SECRET/${TW_USER_ACCESS_SECRET}/g" \
    -e "s/TW_USER_ID/${TW_USER_ID}/g" \
    -e "s/TW_USER_NAME/${TW_USER_NAME}/g" \
    > ~/.tw.yml

tw -yes "てすと $(date '+%Y%m%d%H%M%S')\n https://travis-ci.org/sharkpp/travis-ci-pull-test"
