#!/bin/bash

#echo ------------------------------------------------------------------------------------------
#set | sed -e "s/^\(.*TOKEN=\).*/\1[secure]/g"
#echo ------------------------------------------------------------------------------------------

git config --global user.email "touroku@sharkpp.net"
git config --global user.name  "sharkpp"

git clone --quiet -b gh-pages "https://${GH_TOKEN}@github.com/${TRAVIS_REPO_SLUG}.git" output_prod
pushd output_prod
git clone remote
git fetch
git rebase origin/gh-pages
popd
rm -rf output_prod/*

php sculpin.phar install
php sculpin.phar generate --env=prod

pushd output_prod

git add . -A
git commit -m "Deploy $(date '+%Y%m%d%H%M%S') to GitHub Pages"
git push --quiet "https://${GH_TOKEN}@github.com/${TRAVIS_REPO_SLUG}.git" master:gh-pages

popd

cat .tw.yml | sed \
    -e "s/TW_CONSUMER_KEY/${TW_CONSUMER_KEY}/g" \
    -e "s/TW_CONSUMER_SECRET/${TW_CONSUMER_SECRET}/g" \
    -e "s/TW_USER_ACCESS_TOKEN/${TW_USER_ACCESS_TOKEN}/g" \
    -e "s/TW_USER_ACCESS_SECRET/${TW_USER_ACCESS_SECRET}/g" \
    -e "s/TW_USER_ID/${TW_USER_ID}/g" \
    -e "s/TW_USER_NAME/${TW_USER_NAME}/g" \
    > ~/.tw.yml

which tw

ls -la ~/

# echo -e "てすと $(date '+%Y%m%d%H%M%S')\n https://travis-ci.org/sharkpp/travis-ci-pull-test" | tw --pipe
